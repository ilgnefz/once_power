import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_media_info/flutter_media_info.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:once_power/constants/ext.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/src/rust/api/simple.dart';
import 'package:path/path.dart' as path;
import 'package:string_util_xx/StringUtilxx.dart';
import 'package:xml/xml.dart';

import 'format.dart';
import 'verify.dart';

String getFileName(String filePath) => FileSystemEntity.isFileSync(filePath)
    ? path.basenameWithoutExtension(filePath)
    : path.basename(filePath);

String getExtension(String filePath) => FileSystemEntity.isFileSync(filePath)
    ? path.extension(filePath).substring(1)
    : 'dir';

FileClassify getFileClassify(String ext) {
  ext = ext.toLowerCase();
  if (image.contains(ext)) return FileClassify.image;
  if (video.contains(ext)) return FileClassify.video;
  if (doc.contains(ext)) return FileClassify.doc;
  if (audio.contains(ext)) return FileClassify.audio;
  if (archive.contains(ext)) return FileClassify.archive;
  if (folder == ext) return FileClassify.folder;
  return FileClassify.other;
}

final _folderSizeCache = <String, int>{};
Future<int> calculateSize(String folderPath) async {
  if (_folderSizeCache.containsKey(folderPath)) {
    return _folderSizeCache[folderPath]!;
  }
  Directory dir = Directory(folderPath);
  List<FileSystemEntity> entities = <FileSystemEntity>[];
  await for (FileSystemEntity entity in dir.list(recursive: true)) {
    entities.add(entity);
  }
  List<int> sizes = await Future.wait(
    entities.map((entity) async {
      if (entity is File) {
        FileStat stat = await entity.stat();
        return stat.size;
      }
      return 0;
    }),
  );
  int totalSize = sizes.fold(0, (sum, size) => sum + size);
  _folderSizeCache[folderPath] = totalSize;
  return totalSize;
}

FileMetaInfo? getAudioInfo(String filePath) {
  Mediainfo mi = Mediainfo()..quickLoad(filePath);
  String title = audioMediaInfo(mi, "Title");
  String album = audioMediaInfo(mi, "Album");
  String artist = audioMediaInfo(mi, "Performer");
  String year = audioMediaInfo(mi, "Recorded_Date");
  mi.close();
  return FileMetaInfo(title: title, album: album, artist: artist, year: year);
}

String audioMediaInfo(Mediainfo mi, String parameter) =>
    mi.getInfo(MediaInfoStreamType.mediaInfoStreamGeneral, 0, parameter);

String videoMediaInfo(Mediainfo mi, String parameter) =>
    mi.getInfo(MediaInfoStreamType.mediaInfoStreamVideo, 0, parameter);

String imageMediaInfo(Mediainfo mi, String parameter) =>
    mi.getInfo(MediaInfoStreamType.mediaInfoStreamImage, 0, parameter);

Future<DateTime?> getExifDate(String filePath) async {
  final String? captureDate = await getImageCaptureDate(imagePath: filePath);
  return captureDate != null ? formatExifDate(captureDate) : null;
}

Future<Resolution> getImageDimensions(String assetPath) async {
  // 调试计算图片尺寸耗时
  Stopwatch stopwatch = Stopwatch()..start();
  if (assetPath.endsWith('.psd')) return getPsdDimensions(assetPath);
  if (assetPath.endsWith('.svg')) return await getSvgDimensions(assetPath);
  try {
    File file = File(assetPath);
    SizeResult result = ImageSizeGetter.getSizeResult(FileInput(file));
    return Resolution(result.size.width, result.size.height);
  } catch (e) {
    debugPrint('获取图片尺寸失败: $assetPath, 错误: $e');
    return Resolution.zero;
  } finally {
    double cost = stopwatch.elapsedMicroseconds / 1000000;
    debugPrint('获取图片尺寸耗时: $cost');
  }
}

Resolution getPsdDimensions(String assetPath) {
  Mediainfo mi = Mediainfo()..quickLoad(assetPath);
  String width = imageMediaInfo(mi, 'Width');
  String height = imageMediaInfo(mi, 'Height');
  mi.close();
  int rWidth = width.isEmpty ? 0 : int.parse(width);
  int rHeight = height.isEmpty ? 0 : int.parse(height);
  return Resolution(rWidth, rHeight);
}

Future<Resolution> getSvgDimensions(String svgFilePath) async {
  try {
    File file = File(svgFilePath);
    String svgString = await file.readAsString();
    XmlDocument document = XmlDocument.parse(svgString);
    XmlElement svgElement = document.rootElement;
    String? widthStr = svgElement.getAttribute('width');
    String? heightStr = svgElement.getAttribute('height');
    double? width;
    double? height;
    if (widthStr != null && heightStr != null) {
      width = double.tryParse(widthStr.replaceAll(RegExp(r'[^0-9.]'), ''));
      height = double.tryParse(heightStr.replaceAll(RegExp(r'[^0-9.]'), ''));
    }

    // 如果 width 和 height 属性不存在，尝试从 viewBox 属性获取尺寸
    if (width == null || height == null) {
      final viewBoxStr = svgElement.getAttribute('viewBox');
      if (viewBoxStr != null) {
        final viewBoxValues = viewBoxStr.split(' ');
        if (viewBoxValues.length == 4) {
          width = double.tryParse(viewBoxValues[2]);
          height = double.tryParse(viewBoxValues[3]);
        }
      }
    }

    if (width != null && height != null) {
      return Resolution(width.toInt(), height.toInt());
    } else {
      debugPrint('无法获取 SVG 尺寸');
      return Resolution.zero;
    }
  } catch (e) {
    debugPrint('获取 SVG 尺寸失败: $e');
    return Resolution.zero;
  }
}

Resolution getVideoDimensions(String videoPath) {
  Mediainfo mi = Mediainfo()..quickLoad(videoPath);
  String width = videoMediaInfo(mi, "Width");
  String height = videoMediaInfo(mi, "Height");
  mi.close();
  int rWidth = width.isEmpty ? 0 : int.parse(width);
  int rHeight = height.isEmpty ? 0 : int.parse(height);
  return Resolution(rWidth, rHeight);
}

String getFullName(String name, String extension) {
  if (extension == '' || extension == 'dir') return name;
  return '$name.$extension';
}

String getDotWithExt(String extension) {
  if (extension == '' || extension == 'dir') return '';
  return '.$extension';
}

List<FileInfo> splitSortList(List<FileInfo> fileList, bool reverse) {
  List<FileInfo> chineseList = [];
  List<FileInfo> otherList = [];
  for (FileInfo e in fileList) {
    if (isChinese(e.name)) {
      chineseList.add(e);
    } else {
      otherList.add(e);
    }
  }
  if (reverse) {
    chineseList.sort((a, b) => StringUtilxx_c.compareExtend(b.name, a.name));
    otherList.sort((a, b) => b.name.compareTo(a.name));
    return [...chineseList, ...otherList];
  }
  chineseList.sort((a, b) => StringUtilxx_c.compareExtend(a.name, b.name));
  otherList.sort((a, b) => a.name.compareTo(b.name));
  return [...otherList, ...chineseList];
}

(int, int) getLenNum(String match, int nameLen) {
  int start = 0, end = 0;
  List<String> matchText = match.trim().split(' ');
  bool isDigit = matchText.every((e) => int.tryParse(e) != null);
  if (isDigit) {
    if (matchText.length == 1) {
      int first = int.parse(matchText.first);
      if (first > 0) end = first;
      if (first < 0) {
        start = nameLen + first;
        end = nameLen;
      }
    } else if (matchText.length > 1) {
      int first = int.parse(matchText.first);
      int last = int.parse(matchText.last);
      if (first > 0) start = first - 1;
      if (last > 0) end = last;
      if (first < 0) start = nameLen + first;
      if (last < 0) end = nameLen + last + 1;
    }
    start = start > nameLen - 1 ? nameLen - 1 : start;
    end = end > nameLen ? nameLen : end;
    if (end < start) start = 0;
  } else {
    end = match.length > nameLen ? nameLen : match.length;
  }
  return (start < 0 ? 0 : start, end < 0 ? 0 : end);
}
