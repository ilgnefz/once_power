import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_info/flutter_media_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:once_power/constants/ext.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/cores/sort.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/src/rust/api/simple.dart';
import 'package:path/path.dart' as path;
import 'package:string_util_xx/StringUtilxx.dart';
import 'package:xml/xml.dart';

import 'format.dart';
import 'verify.dart';

String getFileName(String filePath) => FileSystemEntity.isFileSync(filePath)
    ? path.basenameWithoutExtension(filePath)
    : path.basename(filePath);

String getExtension(String filePath) {
  bool isFile = FileSystemEntity.isFileSync(filePath);
  String extension = 'dir';
  if (isFile) {
    extension = path.extension(filePath);
    if (extension != '') extension = extension.substring(1);
  }
  return extension;
}

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

String getDateName(DateType type, int dateLen, FileInfo file) {
  String date = formatDateTime(file.createdDate);
  if (type.isModifiedDate) date = formatDateTime(file.modifiedDate);
  if (type.isEarliestDate) date = formatDateTime(sortDateTime(file).first);
  if (type.isLatestDate) date = formatDateTime(sortDateTime(file).last);
  if (type.isExifDate) {
    DateTime dateTime = file.exifDate ?? sortDateTime(file).first;
    date = formatDateTime(dateTime);
  }
  return date.substring(0, dateLen > date.length ? date.length : dateLen);
}

String getFolderName(String folder) => path.basename(folder);

(String, String) getNameExt(String name, FileClassify classify) {
  if (!name.contains('.')) {
    return (name, classify.isFolder ? 'dir' : '');
  }
  int index = name.lastIndexOf('.');
  String extension = name.substring(index + 1);
  String nameWithoutExtension = name.substring(0, index);
  return (nameWithoutExtension, extension);
}

String getRandomValue(List<String> list, int len) {
  if (list.isEmpty) return '';
  Random random = Random();
  String content = list.join('');
  String result = '';
  for (int i = 0; i < len; i++) {
    int index = random.nextInt(content.length);
    result += content[index];
  }
  return result;
}

FileInfo? getSameFile(List<FileInfo> list, String newPath) {
  List<FileInfo> checkList = list.where((e) => e.checked).toList();
  return checkList.cast<FileInfo?>().firstWhere(
        (e) => e?.path == newPath,
        orElse: () => null,
      );
}

String getTempPath(String folder, String fileName) {
  String name = '$fileName${DateTime.now().hashCode}.once-power.tmp';
  return path.join(folder, name);
}

String getOldPath(FileInfo file) {
  String name = file.newName;
  String parent = file.parent;
  String extension = file.ext;
  String nameWithExt = getFullName(name, extension);
  return path.join(parent, nameWithExt);
}

String getNewPath(FileInfo file) {
  String name = file.newName;
  String parent = file.parent;
  String extension = file.newExt;
  String nameWithExt = getFullName(name, extension);
  return path.join(parent, nameWithExt);
}

String getTopPath(String filePath) {
  final separator = Platform.pathSeparator;
  final pathList =
      filePath.split(separator).where((e) => e.isNotEmpty).toList();
  final commonDirs = {
    'Documents',
    'Pictures',
    'Downloads',
    'Music',
    'Videos',
    'Desktop',
  };

  if (Platform.isWindows) {
    if (pathList.isEmpty) return filePath;
    final disk = pathList[0];
    // 仅C盘处理系统目录
    if (disk.toUpperCase() == 'C:') {
      // 处理根目录通用文件夹（如 C:\Pictures）
      if (pathList.length >= 2 && commonDirs.contains(pathList[1])) {
        return '$disk$separator${pathList[1]}'; // 直接拼接磁盘号和目录
      }

      // 处理用户目录通用文件夹（如 C:\Users\John\Pictures）
      if (pathList.length >= 4 &&
          pathList[1] == 'Users' &&
          commonDirs.contains(pathList[3])) {
        return '$disk$separator${pathList[1]}\\${pathList[2]}\\${pathList[3]}';
      }
    }
    // 返回磁盘根目录下的第一层目录（如 C:\Program Files）
    return pathList.length >= 2
        ? '$disk$separator${pathList[1]}'
        : '$disk$separator'; // 处理纯磁盘根目录（如 C:\）
  } else {
    // macOS/Linux 处理逻辑
    final homePrefix = Platform.isMacOS ? 'Users' : 'home';
    final userIndex = pathList.indexWhere((e) => e == homePrefix);
    // 处理用户主目录下的通用文件夹
    if (userIndex != -1 && pathList.length > userIndex + 2) {
      final userDirs = pathList.sublist(userIndex + 2);
      final topDirIndex = userDirs.indexWhere((e) => commonDirs.contains(e));
      if (topDirIndex != -1) {
        return path.join(
          separator,
          pathList.take(userIndex + 2 + topDirIndex + 1).join(separator),
        );
      }
      return path.join(separator, pathList.take(userIndex + 2).join(separator));
    }
    // 处理根目录下的第一层目录
    return pathList.isEmpty ? filePath : path.join(separator, pathList.first);
  }
}

Future<InfoDetail?> checkFile(
  WidgetRef ref,
  List<FileInfo> list,
  FileInfo file, [
  bool isUndo = false,
]) async {
  String newNameWithExt = isUndo
      ? path.dirname(file.beforePath)
      : getFullName(file.newName, file.newExt);
  String newPath =
      isUndo ? file.beforePath : path.join(file.parent, newNameWithExt);
  bool isExist = await checkExist(ref, list, newPath, isUndo: isUndo);
  if (isExist) {
    return InfoDetail(
      file: getFullName(file.name, file.ext),
      message: ' ${tr(AppL10n.errExists, namedArgs: {'name': newNameWithExt})}',
    );
  }
  return null;
}

int getAllSize(WidgetRef ref) {
  int totalSize = 0;
  for (FileInfo file in ref.watch(fileListProvider)) {
    if (!file.checked) continue;
    totalSize += file.size;
  }
  return totalSize;
}
