import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:path/path.dart' as path;

import 'info.dart';

bool isEnglish(BuildContext context) => context.locale == Locale('en', 'US');

bool isChinese(String text) => RegExp(r'[\u4e00-\u9fa5]').hasMatch(text);

bool isExist(WidgetRef ref, String filePath) =>
    ref.watch(fileListProvider).any((e) => e.path == filePath);

bool isCheck(WidgetRef ref, FileClassify classify) {
  if (classify.isAudio) return ref.watch(checkAudioProvider);
  if (classify.isOther) return ref.watch(checkOtherProvider);
  if (classify.isImage) return ref.watch(checkImageProvider);
  if (classify.isDoc) return ref.watch(checkTextProvider);
  if (classify.isVideo) return ref.watch(checkVideoProvider);
  if (classify.isArchive) return ref.watch(checkArchiveProvider);
  return ref.watch(checkFolderProvider);
}

Future<bool> fileExist(FileInfo file) async {
  bool isDir = file.type.isFolder;
  if (isDir) {
    return await Directory(file.path).exists();
  } else {
    return await File(file.path).exists();
  }
}

bool isAll(String group) {
  List<String> all = ['all', '全部'];
  return all.contains(group);
}

Future<bool> isTrueExist(String filePath) async {
  String parentPath = path.dirname(filePath);
  final entities = await Directory(parentPath).list().toList();
  for (final entity in entities) {
    if (entity.path == filePath) return true;
  }
  return false;
}

bool isSameDisk(String oldPath, String newPath) {
  // Windows系统专用处理
  if (Platform.isWindows) {
    // 获取规范化路径
    String normOld = path.normalize(oldPath).toLowerCase();
    String normNew = path.normalize(newPath).toLowerCase();
    // 正则匹配盘符（支持C:、c:、网络路径）
    final driveRegex = RegExp(r'^(\\\\[^\\]+\\)|([a-z]:\\)');
    String driveOld = driveRegex.stringMatch(normOld) ?? '';
    String driveNew = driveRegex.stringMatch(normNew) ?? '';
    return driveOld == driveNew;
  }
  // 其他系统比较根目录
  return path.rootPrefix(oldPath) == path.rootPrefix(newPath);
}

bool isSameNewPath(List<FileInfo> list, String newPath) {
  int count = list.fold(0, (sum, file) {
    String currentPath = getNewPath(file);
    return sum + (currentPath == newPath ? 1 : 0);
  });
  return count > 1;
}

bool isShowView(WidgetRef ref) =>
    ref.watch(isViewModeProvider) && !ref.watch(currentModeProvider).isOrganize;
