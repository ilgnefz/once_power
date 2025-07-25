import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/extension.dart';
import 'package:once_power/models/file_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/progress.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/info.dart';
import 'package:path/path.dart' as path;

bool isViewNoOrganize(WidgetRef ref) =>
    ref.watch(isViewModeProvider) && !ref.watch(currentModeProvider).isOrganize;

bool isChinese(String text) => RegExp(r'[\u4e00-\u9fa5]').hasMatch(text);

bool isImgVideo(String file) {
  String extension = getExtension(file).toLowerCase();
  if (extension.isEmpty) {
    String name = getPathName(file);
    if (name.startsWith('.')) extension = name.substring(1);
  }
  return image.contains(extension) || video.contains(extension);
}

bool isExist(WidgetRef ref, String filePath) =>
    ref.watch(fileListProvider).any((e) => e.filePath == filePath);

bool isCheck(WidgetRef ref, FileClassify classify) {
  if (classify == FileClassify.audio) return ref.watch(checkAudioProvider);
  if (classify == FileClassify.other) return ref.watch(checkOtherProvider);
  if (classify == FileClassify.image) return ref.watch(checkImageProvider);
  if (classify == FileClassify.doc) return ref.watch(checkTextProvider);
  if (classify == FileClassify.video) return ref.watch(checkVideoProvider);
  if (classify == FileClassify.zip) return ref.watch(checkZipProvider);
  return ref.watch(checkFolderProvider);
}

bool isEnableMatch(WidgetRef ref) {
  FunctionMode mode = ref.watch(currentModeProvider);
  if (mode.isReserve) {
    return ref.watch(currentReserveTypeProvider).isEmpty &&
        !ref.watch(isDateRenameProvider) &&
        !ref.watch(modifyClearProvider);
  }
  return true;
}

bool isEnableModify(WidgetRef ref) {
  FunctionMode mode = ref.watch(currentModeProvider);
  if (mode.isReplace) {
    return !ref.watch(isDateRenameProvider);
  }
  if (mode.isReserve) {
    return ref.watch(currentReserveTypeProvider).isEmpty &&
        !ref.watch(isDateRenameProvider) &&
        !ref.watch(matchClearProvider);
  }
  return true;
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

bool disabledBtn(WidgetRef ref) {
  bool isApplying = ref.watch(isApplyingProvider);
  bool isEmpty = ref.watch(fileListProvider).where((e) => e.checked).isEmpty;
  return isApplying || isEmpty;
}

String formatResolution(Resolution resolution) =>
    '${resolution.width} x ${resolution.height}';
