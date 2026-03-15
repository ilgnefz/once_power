import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_media_info/flutter_media_info.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:once_power/const/extension.dart';
import 'package:once_power/core/sort.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/enum/rule.dart';
import 'package:once_power/model/file.dart';
import 'package:string_util_xx/StringUtilxx.dart';
import 'package:path/path.dart' as path;
import 'package:xml/xml.dart';

import 'format.dart';
import 'verify.dart';

bool getCompareResult(ComparisonOperator operator, String value, String info) {
  switch (operator) {
    case ComparisonOperator.contain:
      return info.contains(value);
    case ComparisonOperator.notContain:
      return !info.contains(value);
    case ComparisonOperator.equal:
      return info == value;
    case ComparisonOperator.notEqual:
      return info != value;
    case ComparisonOperator.before:
      try {
        if (int.tryParse(value) != null && value.length == 4) {
          value = '$value-01-01';
        }
        return DateTime.parse(info).isBefore(DateTime.parse(value));
      } catch (e) {
        return false;
      }
    case ComparisonOperator.after:
      try {
        if (int.tryParse(value) != null && value.length == 4) {
          value = '$value-12-31';
        }
        return DateTime.parse(info).isAfter(DateTime.parse(value));
      } catch (e) {
        return false;
      }
    case ComparisonOperator.beforeOrEqual:
      try {
        if (int.tryParse(value) != null && value.length == 4) {
          value = '$value-12-31';
        }
        DateTime infoDate = DateTime.parse(info);
        DateTime valueDate = DateTime.parse(value);
        return infoDate.isBefore(valueDate) ||
            infoDate.isAtSameMomentAs(valueDate);
      } catch (e) {
        return false;
      }
    case ComparisonOperator.afterOrEqual:
      try {
        if (int.tryParse(value) != null && value.length == 4) {
          value = '$value-01-01';
        }
        DateTime infoDate = DateTime.parse(info);
        DateTime valueDate = DateTime.parse(value);
        return infoDate.isAfter(valueDate) ||
            infoDate.isAtSameMomentAs(valueDate);
      } catch (e) {
        return false;
      }
  }
}

DateInfo? getDate(DateType type, FileInfo file) {
  switch (type) {
    case DateType.created:
      return file.createdDate;
    case DateType.modified:
      return file.modifiedDate;
    case DateType.accessed:
      return file.accessedDate;
    case DateType.exif:
      return file.metaInfo?.capture;
    case DateType.earliest:
      return sortDateTime(file).first;
    case DateType.latest:
      return sortDateTime(file).last;
  }
}

DateInfo? getDateInfo(DateTime? date) {
  if (date == null) return null;
  DateInfo dateInfo = DateInfo(date, weekdayNames[date.weekday - 1]);
  return dateInfo;
}

String getDateName(DateTime? dateTime, int dateLen) {
  if (dateTime == null) return '';
  String date = formatDateTime(dateTime);
  return date.substring(0, dateLen > date.length ? date.length : dateLen);
}

FileType getFileType(String ext) {
  ext = ext.toLowerCase();
  if (AppExtension.image.contains(ext)) return FileType.image;
  if (AppExtension.video.contains(ext)) return FileType.video;
  if (AppExtension.doc.contains(ext)) return FileType.doc;
  if (AppExtension.audio.contains(ext)) return FileType.audio;
  if (AppExtension.archive.contains(ext)) return FileType.archive;
  // if (AppExtension.folder == ext) return FileClassify.folder;
  return FileType.other;
}

String getFolderName(String folder) => path.basename(folder);

String getFullName(String name, String extension) {
  if (extension == '') return name;
  return '$name.$extension';
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

String getRuleTypeValue(InfoType type, FileInfo file) {
  switch (type) {
    case InfoType.name:
      return file.name;
    case InfoType.newName:
      return file.newName;
    case InfoType.folder:
      return file.parent;
    case InfoType.extension:
      return file.extension;
    case InfoType.createdDate:
      return file.createdDate.date.toString();
    case InfoType.modifiedDate:
      return file.modifiedDate.date.toString();
    case InfoType.accessedDate:
      return file.accessedDate.date.toString();
    case InfoType.capturedDate:
      return file.metaInfo?.capture?.date.toString() ?? '';
  }
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

Future<(Resolution, FileMetaInfo)> getVideoInfo(String filePath) async {
  Mediainfo mi = Mediainfo()..quickLoad(filePath);
  String width = videoMediaInfo(mi, "Width");
  String height = videoMediaInfo(mi, "Height");
  String make = generalMediaInfo(mi, "com.android.manufacturer");
  String model = generalMediaInfo(mi, "com.android.model");
  String tagged = generalMediaInfo(mi, "Tagged_Date");
  DateTime? capture = DateTime.tryParse(convertToLocalTime(tagged));
  // print(mi.inform());
  mi.close();
  int rWidth = width.isEmpty ? 0 : int.parse(width);
  int rHeight = height.isEmpty ? 0 : int.parse(height);
  return (
    Resolution(rWidth, rHeight),
    FileMetaInfo(
      capture: capture == null ? null : getDateInfo(capture),
      make: make,
      model: model,
    ),
  );
}

String generalMediaInfo(Mediainfo mi, String parameter) =>
    mi.getInfo(MediaInfoStreamType.mediaInfoStreamGeneral, 0, parameter);

String audioMediaInfo(Mediainfo mi, String parameter) =>
    mi.getInfo(MediaInfoStreamType.mediaInfoStreamGeneral, 0, parameter);

String videoMediaInfo(Mediainfo mi, String parameter) =>
    mi.getInfo(MediaInfoStreamType.mediaInfoStreamVideo, 0, parameter);

String imageMediaInfo(Mediainfo mi, String parameter) =>
    mi.getInfo(MediaInfoStreamType.mediaInfoStreamImage, 0, parameter);

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
    // otherList.sort((a, b) => b.name.compareTo(a.name));
    otherList.sort((a, b) => naturalCompare(b.name, a.name));
    return [...chineseList, ...otherList];
  }
  chineseList.sort((a, b) => StringUtilxx_c.compareExtend(a.name, b.name));
  // otherList.sort((a, b) => a.name.compareTo(b.name));
  otherList.sort((a, b) => naturalCompare(a.name, b.name));
  return [...otherList, ...chineseList];
}

int naturalCompare(String a, String b) {
  if (a.isEmpty || b.isEmpty) {
    return a.length.compareTo(b.length);
  }

  final aFirstChar = a[0];
  final bFirstChar = b[0];

  final aIsDigit = aFirstChar.contains(RegExp(r'\d'));
  final bIsDigit = bFirstChar.contains(RegExp(r'\d'));

  if (aIsDigit && bIsDigit) {
    final regExp = RegExp(r'^\d+');
    final aMatch = regExp.firstMatch(a);
    final bMatch = regExp.firstMatch(b);

    if (aMatch != null && bMatch != null) {
      final aNum = int.tryParse(aMatch.group(0)!);
      final bNum = int.tryParse(bMatch.group(0)!);

      if (aNum != null && bNum != null) {
        final result = aNum.compareTo(bNum);
        if (result != 0) return result;
      }
    }

    return a.compareTo(b);
  } else if (aIsDigit) {
    return -1;
  } else if (bIsDigit) {
    return 1;
  } else {
    return a.compareTo(b);
  }
}
