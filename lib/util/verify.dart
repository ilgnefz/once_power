import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:path/path.dart' as path;

bool isAll(String group) {
  List<String> all = ['all', '全部'];
  return all.contains(group);
}

bool isChinese(String text) => RegExp(r'^[\u4e00-\u9fa5]').hasMatch(text);

// bool isEnglish(BuildContext context) => context.locale == Locale('en', 'US');

bool isCheckedClassify(WidgetRef ref, FileType classify) {
  if (classify.isAudio) return ref.watch(checkAudioProvider);
  if (classify.isOther) return ref.watch(checkOtherProvider);
  if (classify.isImage) return ref.watch(checkImageProvider);
  if (classify.isDoc) return ref.watch(checkTextProvider);
  if (classify.isVideo) return ref.watch(checkVideoProvider);
  if (classify.isArchive) return ref.watch(checkArchiveProvider);
  return ref.watch(checkFolderProvider);
}

Future<bool> isExist(bool isFolder, String filePath) async {
  if (isFolder) return await Directory(filePath).exists();
  return await File(filePath).exists();
}

bool isSameDisk(String oldPath, String newPath) =>
    path.rootPrefix(path.normalize(oldPath).toLowerCase()) ==
    path.rootPrefix(path.normalize(newPath).toLowerCase());

// bool isValidFolderPath(String path) {
//   // 检查路径是否为空
//   if (path.isEmpty) return false;

//   // 检查路径是否包含非法字符
//   final illegalChars = RegExp(r'[<>:"/\\|?*]');
//   if (illegalChars.hasMatch(path)) return false;

//   // 检查路径长度是否合法（Windows 最大路径长度为 260 字符）
//   if (path.length > 260) return false;

//   // 检查路径是否为有效的驱动器路径（Windows）
//   if (Platform.isWindows) {
//     final driveRegex = RegExp(r'^[A-Za-z]:\\', caseSensitive: false);
//     if (!driveRegex.hasMatch(path)) {
//       // 检查是否为相对路径
//       final relativeRegex = RegExp(r'^(\.\.?\\|\\)');
//       if (!relativeRegex.hasMatch(path)) {
//         return false;
//       }
//     }
//   }

//   return true;
// }
