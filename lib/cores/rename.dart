import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/utils/verify.dart';
import 'package:path/path.dart' as path;

import 'notification.dart';
import 'update.dart';

Future<bool> runRename(
  WidgetRef ref,
  Future<InfoDetail?> Function(WidgetRef, List<FileInfo>, FileInfo) callback,
  Function(List<InfoDetail>, int) onEnd,
) async {
  duplicateMap.clear();
  List<FileInfo> list = ref.watch(sortListProvider);
  List<FileInfo> checkList = list.where((e) => e.checked).toList();
  int total = checkList.length;
  if (checkList.isEmpty) return false;
  ref.read(totalProvider.notifier).update(total);
  ref.read(isApplyingProvider.notifier).start();
  List<InfoDetail> errors = [];
  ref.read(countProvider.notifier).reset();
  final Stopwatch stopwatch = Stopwatch()..start();
  for (FileInfo file in checkList) {
    final InfoDetail? info = await callback(ref, list, file);
    if (info != null) errors.add(info);
    ref.read(countProvider.notifier).update();
  }
  stopwatch.stop();
  double cost = stopwatch.elapsedMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  await onEnd(errors, total);
  ref.read(isApplyingProvider.notifier).finish();
  return true;
}

Map<String, int> duplicateMap = {};

String autoRenamePath(String newPath, FileInfo file) {
  int counter = 1;

  // Windows和macOS不区分大小写，使用全小写路径进行重复检测
  // Linux区分大小写，但扩展名统一小写，使用原始路径+小写扩展名
  String duplicateKey = Platform.isLinux
      ? path.join(
          path.dirname(newPath),
          path.basenameWithoutExtension(newPath) +
              path.extension(newPath).toLowerCase())
      : newPath.toLowerCase();

  if (duplicateMap.containsKey(duplicateKey)) {
    counter = duplicateMap[duplicateKey]!;
    duplicateMap[duplicateKey] = counter + 1;
  } else {
    duplicateMap[duplicateKey] = 2;
  }

  String prefix = StorageUtil.getString(AppKeys.autoPrefix) ?? '_';
  int digits = StorageUtil.getInt(AppKeys.autoDigits) ?? 2;

  // 使用FileInfo中的新名称和扩展名生成新路径，确保一致性
  return path.join(
    path.dirname(newPath),
    '${file.newName}$prefix${formatNum(counter, digits)}.${file.newExt}',
  );
}

Future<InfoDetail?> rename(
  WidgetRef ref,
  FileInfo file,
  String oldPath,
  String newPath,
) async {
  try {
    if (file.type.isFolder) {
      await Directory(oldPath).rename(newPath);
    } else {
      if (await File(newPath).exists()) newPath = autoRenamePath(newPath, file);
      await File(oldPath).rename(newPath);
    }
    await updateShowInfo(ref, file, newPath);
    return null;
  } catch (e) {
    return renameErrorNotification(e, oldPath, newPath);
  }
}

Future<bool> checkExist(
  WidgetRef ref,
  List<FileInfo> list,
  String filePath, {
  bool isSecond = false,
  bool isUndo = false,
}) async {
  // 检测文件是否存在
  bool isExist = await File(filePath).exists();
  if (Platform.isWindows) isExist = isExist && await isTrueExist(filePath);
  // 存在就继续,否则返回 false
  // print('文件在磁盘吗? $isExist');
  if (isExist) {
    // 检测文件是否在列表中
    FileInfo? sameFile = getSameFile(list, filePath);
    // 文件不在列表中说明无法控制，返回 true，否则继续
    if (sameFile != null) {
      // 如果是isSecond说明是临时重命名的文件，在列表中就不用管，
      // 不在说明在磁盘中无法修改，所以需要返回 true
      bool hasMultipleSamePath = isSameNewPath(list, filePath);
      if (hasMultipleSamePath) return true;
      if (isSecond) return false;
      // print('文件在列表中，当前文件$filePath}');
      return await tempRenameFile(ref, list, sameFile, isUndo);
    }
    return true;
  }
  return false;
}

// 临时重命名文件
Future<bool> tempRenameFile(
  WidgetRef ref,
  List<FileInfo> list,
  FileInfo file, [
  bool isUndo = false,
]) async {
  String oldPath = file.path; // 旧文件路径
  String newFullName = isUndo
      ? path.dirname(file.beforePath)
      : getFullName(file.newName, file.newExt);
  String newPath =
      isUndo ? file.beforePath : path.join(file.parent, newFullName);
  // 检测需要临时修改名称的文件的新名称是否存在 系统中,在系统中就中断返回 true
  bool isExist = await checkExist(ref, list, newPath, isSecond: true);
  // 如果文件存在，就返回 true，无法修改
  if (isExist) return true;
  // 不存在文件就被修改为新名称+随机生成的字符串
  String tempPath = getTempPath(file.parent, newFullName);
  try {
    if (file.type.isFolder) {
      await Directory(oldPath).rename(tempPath);
    } else {
      await File(oldPath).rename(tempPath);
    }
    ref.read(fileListProvider.notifier).updateTempPath(file.id, tempPath);
  } catch (e) {
    //   如果文件不存在，直接删除
    debugPrint('临时修改文件出错: ${e.toString()}');
  }
  return false;
}
