import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/cores/oplog.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/models/rule_type.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/progress.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/utils.dart';
import 'package:path/path.dart' as path;

import 'notification.dart';

Future<void> targetFolderCache(WidgetRef ref, String folder) async {
  if (ref.watch(isSaveConfigProvider)) {
    await StorageUtil.setString(AppKeys.targetFolder, folder);
    List<String> list = StorageUtil.getStringList(AppKeys.targetFolderList);
    if (list.contains(folder)) list.remove(folder);
    list.add(folder);
    await StorageUtil.setStringList(AppKeys.targetFolderList, list);
  }
}

void organizeFolder(WidgetRef ref) async {
  List<FileInfo> list = ref.watch(fileListProvider);
  List<FileInfo> checkList = list.where((e) => e.checked).toList();
  int total = checkList.length;
  if (checkList.isEmpty) return;
  ref.read(totalProvider.notifier).update(total);
  List<InfoDetail> errors = [];
  int count = 0;
  DateTime startTime = DateTime.now();

  bool isRule = ref.watch(useRuleOrganizeProvider);
  bool isTop = ref.watch(useTopParentsProvider);
  if (!isRule && !isTop) {
    String inputFolder = ref.watch(folderControllerProvider).text;
    if (inputFolder == '' || inputFolder.isEmpty) {
      return showOrganizeEmptyNotification();
    }
  }

  if (isRule) {
    RuleTypeValue? rule = StorageUtil.getRuleTypeValue(AppKeys.ruleTypeValue);
    if (rule == null || rule.isEmpty()) return showOrganizeNullNotification();
    List<InfoDetail> list = await ruleOrganize(ref, checkList, rule, count);
    if (list.isNotEmpty) errors.addAll(list);
  } else if (isTop) {
    List<InfoDetail> list = await topParentsOrganize(ref, checkList, count);
    if (list.isNotEmpty) errors.addAll(list);
  } else if (ref.watch(useDateClassifyProvider)) {
    List<InfoDetail> list = await dateClassifyOrganize(ref, checkList, count);
    if (list.isNotEmpty) errors.addAll(list);
  } else {
    List<InfoDetail> list = await normalOrganize(ref, checkList, count);
    if (list.isNotEmpty) errors.addAll(list);
  }
  Duration duration = DateTime.now().difference(startTime);
  double cost = duration.inMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  showOrganizeNotification(errors, total);
  if (ref.watch(isSaveLogProvider)) {
    await removeLogCache(S.current.organizeLogs);
  }
}

Future<List<InfoDetail>> normalOrganize(
    WidgetRef ref, List<FileInfo> list, int count) async {
  List<InfoDetail> errorList = [];
  String targetFolder = ref.watch(folderControllerProvider).text;
  for (FileInfo file in list) {
    InfoDetail? info = await organize(ref, file, targetFolder);
    if (info != null) errorList.add(info);
    ref.read(countProvider.notifier).update(++count);
  }
  return errorList;
}

Future<List<InfoDetail>> ruleOrganize(
    WidgetRef ref, List<FileInfo> list, RuleTypeValue rule, int count) async {
  List<InfoDetail> errorList = [];
  // 检测 rule 中至少有一个不为空
  for (FileInfo file in list) {
    if (rule.image != '' && file.type.isImage) {
      InfoDetail? info = await organize(ref, file, rule.image);
      if (info != null) errorList.add(info);
    }
    if (rule.video != '' && file.type.isVideo) {
      InfoDetail? info = await organize(ref, file, rule.video);
      if (info != null) errorList.add(info);
    }
    if (rule.audio != '' && file.type.isAudio) {
      InfoDetail? info = await organize(ref, file, rule.audio);
      if (info != null) errorList.add(info);
    }
    if (rule.doc != '' && file.type.isDoc) {
      InfoDetail? info = await organize(ref, file, rule.doc);
      if (info != null) errorList.add(info);
    }
    if (rule.zip != '' && file.type.isZip) {
      InfoDetail? info = await organize(ref, file, rule.zip);
      if (info != null) errorList.add(info);
    }
    if (rule.folder != '' && file.type.isFolder) {
      InfoDetail? info = await organize(ref, file, rule.folder);
      if (info != null) errorList.add(info);
    }
    if (rule.other != '' && file.type.isOther) {
      InfoDetail? info = await organize(ref, file, rule.other);
      if (info != null) errorList.add(info);
    }
    ref.read(countProvider.notifier).update(++count);
  }
  return errorList;
}

Future<List<InfoDetail>> topParentsOrganize(
    WidgetRef ref, List<FileInfo> list, int count) async {
  List<InfoDetail> errorList = [];
  for (FileInfo file in list) {
    ref.read(countProvider.notifier).update(++count);
    String targetFolder = getTopPath(file.filePath);
    if (file.parent == targetFolder) continue;
    InfoDetail? info = await organize(ref, file, targetFolder);
    if (info != null) errorList.add(info);
  }
  return errorList;
}

Future<List<InfoDetail>> dateClassifyOrganize(
    WidgetRef ref, List<FileInfo> list, int count) async {
  List<InfoDetail> errorList = [];
  String inputFolder = ref.watch(folderControllerProvider).text;
  for (FileInfo file in list) {
    String dateDir = formatDateTime(file.createdDate).substring(0, 8);
    String targetFolder = path.join(inputFolder, dateDir);
    InfoDetail? info = await organize(ref, file, targetFolder);
    if (info != null) errorList.add(info);
    ref.read(countProvider.notifier).update(++count);
  }
  return errorList;
}

Future<String> renameExistFile(String newPath) async {
  int counter = 1;
  final dir = path.dirname(newPath);
  final ext = path.extension(newPath);
  final baseName = path.basenameWithoutExtension(newPath);
  while (true) {
    bool isExist = await File(newPath).exists();
    if (Platform.isWindows) isExist = isExist && await isTrueExist(newPath);
    if (!isExist) break;
    final newFileName = '$baseName - $counter$ext';
    newPath = path.join(dir, newFileName);
    counter++;
    // 防止意外无限循环
    if (counter > 1000) throw Exception('无法生成可用文件名');
  }
  return newPath;
}

Future<InfoDetail?> organize(
    WidgetRef ref, FileInfo file, String folder) async {
  String oldPath = file.filePath;
  String newPath = path.join(folder, path.basename(oldPath));
  newPath = await renameExistFile(newPath);
  bool isSame = isSameDisk(oldPath, newPath);
  try {
    final parentDir = Directory(path.dirname(newPath));
    if (!await parentDir.exists()) {
      await parentDir.create(recursive: true);
    }
    if (file.type.isFolder) {
      if (isSame) {
        await Directory(oldPath).rename(newPath);
      } else {
        await moveDirectory(ref, oldPath, newPath);
      }
    } else {
      if (isSame) {
        await File(oldPath).rename(newPath);
      } else {
        await File(oldPath).copy(newPath);
        await File(oldPath).delete();
      }
    }
    if (ref.watch(isSaveLogProvider)) await tempSaveLog(ref, oldPath, newPath);
    String parent = path.dirname(newPath);
    ref.read(fileListProvider.notifier).updateFileParent(file.id, parent);
    ref.read(fileListProvider.notifier).updateFilePath(file.id, newPath);
    return null;
  } catch (e) {
    return moveErrorInfo(e, isSame, oldPath, newPath);
  }
}

// 查看文件夹下是否有文件，有就移动自身及所有文件到新文件夹
// 没有就移动自身
Future<void> moveDirectory(
    WidgetRef ref, String oldFolder, String newFolder) async {
  // 创建目标目录（保留原目录名称）
  final targetDir = path.join(newFolder, path.basename(oldFolder));
  await Directory(targetDir).create(recursive: true);

  // 递归遍历所有子项（包含空目录）
  final entities = await Directory(oldFolder).list(recursive: true).toList();

  // 先处理文件
  for (var entity in entities.whereType<File>()) {
    final relativePath = path.relative(entity.path, from: oldFolder);
    final newPath = path.join(targetDir, relativePath);

    // 处理可能的重名文件
    final verifiedPath = await renameExistFile(newPath);
    await entity.copy(verifiedPath);
    await entity.delete();
  }

  // 最后处理目录（确保父目录存在）
  for (var entity in entities.whereType<Directory>()) {
    final relativePath = path.relative(entity.path, from: oldFolder);
    final newDirPath = path.join(targetDir, relativePath);
    await Directory(newDirPath).create(recursive: true);
  }

  // 删除源目录（包括空目录）
  await Directory(oldFolder).delete(recursive: true);
}
