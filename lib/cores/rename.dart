import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/models/file_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/models/two_re_enum.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/progress.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/utils/utils.dart';
import 'package:path/path.dart' as path;

import 'notification.dart';
import 'sort.dart';

String dateName(WidgetRef ref, FileInfo file) {
  String date = formatDateTime(file.createdDate);
  int dateLen = ref.watch(dateLengthValueProvider);
  DateType type = ref.watch(currentDateTypeProvider);
  if (type.isModifiedDate) date = formatDateTime(file.modifiedDate);
  if (type.isEarliestDate) date = formatDateTime(sortDateTime(file).first);
  if (type.isLatestDate) date = formatDateTime(sortDateTime(file).last);
  if (type.isExifDate) {
    DateTime dateTime = file.exifDate ?? sortDateTime(file).first;
    date = formatDateTime(dateTime);
  }
  return date.substring(0, dateLen > date.length ? date.length : dateLen);
}

Future<void> runRename(
    WidgetRef ref,
    Future<InfoDetail?> Function(WidgetRef, List<FileInfo>, FileInfo) callback,
    Function(List<InfoDetail>, int) onEnd) async {
  List<FileInfo> list = ref.watch(fileListProvider);
  List<FileInfo> checkList = list.where((e) => e.checked).toList();
  int total = checkList.length;
  if (checkList.isEmpty) return;
  ref.read(totalProvider.notifier).update(total);
  List<InfoDetail> errors = [];
  int count = 0;
  DateTime startTime = DateTime.now();
  for (FileInfo file in checkList) {
    InfoDetail? info = await callback(ref, list, file);
    if (info != null) errors.add(info);
    ref.read(countProvider.notifier).update(++count);
    // await Future.delayed(const Duration(microseconds: 1));
  }
  Duration duration = DateTime.now().difference(startTime);
  double cost = duration.inMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  await onEnd(errors, total);
}

Future<InfoDetail?> rename(
    WidgetRef ref, FileInfo file, String oldPath, String newPath) async {
  try {
    if (file.type.isFolder) {
      await Directory(oldPath).rename(newPath);
    } else {
      await File(oldPath).rename(newPath);
    }
    await updateShowInfo(ref, file, newPath);
    return null;
  } catch (e) {
    return renameErrorInfo(e, oldPath, newPath);
  }
}

// 检测文件是否存在,存在列表中返回 false,存在系统磁盘返回 true
Future<bool> checkExist(WidgetRef ref, List<FileInfo> list, String filePath,
    {bool isSecond = false, bool isUndo = false}) async {
  // 检测文件是否存在
  bool isExist = await File(filePath).exists();
  if (Platform.isWindows) isExist = isExist && isTrueExist(filePath);
  // 存在就继续,否则返回 false
  // print('文件在磁盘吗? $isExist');
  if (isExist) {
    // 检测文件是否在列表中
    FileInfo? sameFile = getSameFile(list, filePath);
    // 文件不在列表中说明无法控制，返回 true，否则继续
    if (sameFile != null) {
      // 如果是isSecond说明是临时重命名的文件，在列表中就不用管，
      // 不在说明在磁盘中无法修改，所以需要返回 true
      bool hasMultipSamePath = isSameNewPath(list, filePath);
      if (hasMultipSamePath) return true;
      if (isSecond) return false;
      // print('文件在列表中，当前文件$filePath}');
      return await tempRenameFile(ref, list, sameFile, isUndo);
    }
    return true;
  }
  return false;
}

// 临时重命名文件
Future<bool> tempRenameFile(WidgetRef ref, List<FileInfo> list, FileInfo file,
    [bool isUndo = false]) async {
  // print('收到文件了存在的文件${file.name}');
  String oldPath = file.filePath; // 旧文件路径
  String newFullName = isUndo
      ? path.dirname(file.beforePath)
      : getNameWithExt(file.newName, file.newExtension);
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
    debugPrint('临时修改文件出错:${e.toString()}');
  }
  return false;
}
