import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart' hide Size;
import 'package:once_power/cores/rename.dart';
import 'package:once_power/cores/sort.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/extension.dart';
import 'package:once_power/models/file_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/two_re_enum.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/src/rust/api/simple.dart';
import 'package:path/path.dart' as path;
import 'package:xml/xml.dart';

import 'format.dart';

(String, String) getNameAndExt(String name, FileClassify classify) {
  if (!name.contains('.')) {
    return (name, classify.isFolder ? 'dir' : '');
  }
  int index = name.lastIndexOf('.');
  String extension = name.substring(index + 1);
  String nameWithoutExtension = name.substring(0, index);
  return (nameWithoutExtension, extension);
}

String getExtension(String filePath) {
  bool isFile = FileSystemEntity.isFileSync(filePath);
  String extension = 'dir';
  if (isFile) {
    extension = path.extension(filePath);
    if (extension != '') extension = extension.substring(1);
  }
  return extension;
}

String getPathName(String filePath) {
  bool isFile = FileSystemEntity.isFileSync(filePath);
  return isFile
      ? path.basenameWithoutExtension(filePath)
      : path.basename(filePath);
}

Future<DateTime?> getExifDate(String filePath) async {
  final String? captureDate = await getImageCaptureDate(imagePath: filePath);
  return captureDate != null ? formatExifDate(captureDate) : null;
}

FileClassify getFileClassify(String extension) {
  extension = extension.toLowerCase();
  if (audio.contains(extension)) return FileClassify.audio;
  if (folder == extension) return FileClassify.folder;
  if (image.contains(extension)) return FileClassify.image;
  if (doc.contains(extension)) return FileClassify.doc;
  if (video.contains(extension)) return FileClassify.video;
  if (zip.contains(extension)) return FileClassify.zip;
  return FileClassify.other;
}

(bool, String, int, int) getPrefixInfo(WidgetRef ref) {
  bool swapPrefix = ref.watch(isSwapPrefixProvider);
  String prefixStr = ref.watch(prefixControllerProvider).text;
  int pStartSerial = ref.watch(prefixSerialStartProvider);
  int ppSerialLen = ref.watch(prefixSerialLengthProvider);
  return (swapPrefix, prefixStr, pStartSerial, ppSerialLen);
}

(bool, String, int, int) getSuffixInfo(WidgetRef ref) {
  bool swapSuffix = ref.watch(isSwapSuffixProvider);
  String suffixStr = ref.watch(suffixControllerProvider).text;
  int sStartSerial = ref.watch(suffixSerialStartProvider);
  int ssSerialLen = ref.watch(suffixSerialLengthProvider);
  return (swapSuffix, suffixStr, sStartSerial, ssSerialLen);
}

String? filePrefixStr(WidgetRef ref, bool isCycle, int index) {
  UploadMarkInfo? info = ref.watch(prefixUploadMarkProvider);
  if (info == null) return null;
  String? content = info.content;
  List<String> list = strToList(content);
  if (isCycle) return list[index % list.length];
  return index >= list.length ? '' : list[index];
}

String? fileSuffixStr(WidgetRef ref, bool isCycle, int index) {
  UploadMarkInfo? info = ref.watch(suffixUploadMarkProvider);
  if (info == null) return null;
  String? content = info.content;
  List<String> list = strToList(content);
  if (isCycle) return list[index % list.length];
  return index >= list.length ? '' : list[index];
}

String getMarkStr(
  WidgetRef ref,
  bool isDate,
  bool isSwap,
  String str,
  int startSerial,
  int serialLen,
  int index,
  FileInfo file,
  Map<String, dynamic> classifyMap,
) {
  if (isDate) {
    String date = dateName(ref, file);
    (classifyMap, index) = calculateIndex(classifyMap, [date], file);
    if (ref.watch(caseFileProvider) && !ref.watch(caseExtensionProvider)) {
      (_, index) = calculateIndex(classifyMap, [date, file.type.label], file);
    }
    if (ref.watch(caseExtensionProvider)) {
      (_, index) = calculateIndex(classifyMap, [date, file.extension], file);
    }
  } else {
    if (ref.watch(caseFileProvider) && !ref.watch(caseExtensionProvider)) {
      (_, index) = calculateIndex(classifyMap, [file.type.label], file);
    }
    if (ref.watch(caseExtensionProvider)) {
      (_, index) = calculateIndex(classifyMap, [file.extension], file);
    }
  }
  int startIndex = startSerial + index;
  String serial = formatNum(startIndex, serialLen);
  return isSwap ? '$serial$str' : '$str$serial';
}

/// DeepSeek-R1 生成的代码
(Map<String, dynamic>, int) calculateIndex(
  Map<String, dynamic> classifyMap,
  List<String> keys,
  FileInfo file,
) {
  Map<String, dynamic> currentLevel = classifyMap;

  for (int i = 0; i < keys.length; i++) {
    final key = keys[i];
    final isLastKey = i == keys.length - 1;

    if (isLastKey) {
      if (currentLevel[key] is Map<String, dynamic>) {
        final files = currentLevel[key]['_files'] as List<FileInfo>;
        if (!files.contains(file)) files.add(file);
      } else {
        if (!currentLevel.containsKey(key)) currentLevel[key] = <FileInfo>[];
        final files = currentLevel[key] as List<FileInfo>;
        if (!files.contains(file)) files.add(file);
      }
    } else {
      if (currentLevel.containsKey(key) &&
          currentLevel[key] is List<FileInfo>) {
        final existingFiles = currentLevel[key] as List<FileInfo>;
        currentLevel[key] = {'_files': existingFiles};
      }

      if (!currentLevel.containsKey(key)) {
        currentLevel[key] = <String, dynamic>{};
      }
      currentLevel = currentLevel[key] as Map<String, dynamic>;
    }
  }

  final lastKey = keys.last;
  if (currentLevel[lastKey] is Map<String, dynamic>) {
    final files = currentLevel[lastKey]['_files'] as List<FileInfo>;
    return (classifyMap, files.indexOf(file));
  }
  final files = currentLevel[lastKey] as List<FileInfo>;
  return (classifyMap, files.indexOf(file));
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

int getNum(String value) {
  RegExp exp = RegExp(r'\d+');
  RegExpMatch? match = exp.firstMatch(value);
  if (match != null) return int.parse(match.group(0)!);
  return 0;
}

String getNameWithExt(String name, String extension) {
  if (extension == '' || extension == 'dir') return name;
  return '$name.$extension';
}

String getDotWithExt(String extension) {
  if (extension == '' || extension == 'dir') return '';
  return '.$extension';
}

String getFolderName(String folder) => path.basename(folder);

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
  return checkList
      .cast<FileInfo?>()
      .firstWhere((e) => e?.filePath == newPath, orElse: () => null);
}

String getTempPath(String folder, String fileName) {
  String name = '$fileName${DateTime.now().hashCode}.once-power.tmp';
  return path.join(folder, name);
}

String getOldPath(FileInfo file) {
  String name = file.newName;
  String parent = file.parent;
  String extension = file.extension;
  String nameWithExt = getNameWithExt(name, extension);
  return path.join(parent, nameWithExt);
}

String getNewPath(FileInfo file) {
  String name = file.newName;
  String parent = file.parent;
  String extension = file.newExtension;
  String nameWithExt = getNameWithExt(name, extension);
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
    'Desktop'
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
        return path.join(separator,
            pathList.take(userIndex + 2 + topDirIndex + 1).join(separator));
      }
      return path.join(separator, pathList.take(userIndex + 2).join(separator));
    }
    // 处理根目录下的第一层目录
    return pathList.isEmpty ? filePath : path.join(separator, pathList.first);
  }
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

int getAllSize(WidgetRef ref) {
  int totalSize = 0;
  for (FileInfo file in ref.watch(fileListProvider)) {
    if (!file.checked) continue;
    totalSize += file.size;
  }
  return totalSize;
}

final _folderSizeCache = <String, int>{};

Future<int> calculateSize(String folderPath) async {
  if (_folderSizeCache.containsKey(folderPath)) {
    return _folderSizeCache[folderPath]!;
  }
  final dir = Directory(folderPath);
  final entities = <FileSystemEntity>[];
  await for (final entity in dir.list(recursive: true)) {
    entities.add(entity);
  }
  final sizes = await Future.wait(entities.map((entity) async {
    if (entity is File) {
      final stat = await entity.stat();
      return stat.size;
    }
    return 0;
  }));
  final totalSize = sizes.fold(0, (sum, size) => sum + size);
  _folderSizeCache[folderPath] = totalSize;
  return totalSize;
}

Future<Resolution> getImageDimensions(String assetPath) async {
  // 调试计算图片尺寸耗时
  final stopwatch = Stopwatch()..start();
  if (assetPath.endsWith('.psd')) return Resolution.zero;
  if (assetPath.endsWith('.svg')) return await getSvgDimensions(assetPath);
  try {
    final file = File(assetPath);
    final result = ImageSizeGetter.getSizeResult(FileInput(file));
    return Resolution(result.size.width, result.size.height);
  } catch (e) {
    debugPrint('获取图片尺寸失败: $assetPath, 错误: $e');
    return Resolution.zero;
  } finally {
    final cost = stopwatch.elapsedMicroseconds / 1000000;
    debugPrint('获取图片尺寸耗时: $cost');
  }
}

Future<Resolution> getSvgDimensions(String svgFilePath) async {
  try {
    // 读取 SVG 文件内容
    final file = File(svgFilePath);
    final svgString = await file.readAsString();
    // 解析 SVG 内容为 XML 文档
    final document = XmlDocument.parse(svgString);
    // 查找根 <svg> 元素
    final svgElement = document.rootElement;
    // 尝试从 width 和 height 属性获取尺寸
    String? widthStr = svgElement.getAttribute('width');
    String? heightStr = svgElement.getAttribute('height');
    double? width;
    double? height;
    if (widthStr != null && heightStr != null) {
      // 去除可能的单位（如 px）
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

// Size getVideoDimensions(String videoPath) {
//   Mediainfo mi = Mediainfo();
//   try {
//     mi.quickLoad(videoPath);
//     final width =
//         mi.getInfo(MediaInfoStreamType.mediaInfoStreamVideo, 0, "Width");
//     final height =
//         mi.getInfo(MediaInfoStreamType.mediaInfoStreamVideo, 0, "Height");
//     // String inform = mi.inform();
//     // print('视频信息: $inform');
//     return Size(int.parse(width), int.parse(height));
//   } catch (e) {
//     debugPrint('获取视频尺寸失败: $e');
//     return Size.zero;
//   } finally {
//     mi.close();
//   }
// }

String getThemeModeName(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return S.current.lightTheme;
    case ThemeMode.dark:
      return S.current.darkTheme;
    case ThemeMode.system:
      return S.current.system;
  }
}

IconData getThemeModeIcon(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return Icons.light_mode_rounded;
    case ThemeMode.dark:
      return Icons.dark_mode_rounded;
    case ThemeMode.system:
      return Icons.brightness_4_rounded;
  }
}
