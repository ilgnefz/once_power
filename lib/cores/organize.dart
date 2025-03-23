import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/cores/oplog.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/models/progress.dart';
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
  ref.read(countProvider.notifier).clear();
  ref.read(isApplyingProvider.notifier).start();
  List<InfoDetail> errors = [];
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
    if (rule == null || rule.isEmpty()) {
      clearOrganize(ref);
      return showOrganizeNullNotification();
    }
    errors.addAll(await ruleOrganize(ref, checkList, rule));
  } else if (isTop) {
    errors.addAll(await topParentsOrganize(ref, checkList));
  } else if (ref.watch(useDateClassifyProvider)) {
    errors.addAll(await dateClassifyOrganize(ref, checkList));
  } else {
    errors.addAll(await normalOrganize(ref, checkList));
  }
  Duration duration = DateTime.now().difference(startTime);
  double cost = duration.inMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  clearOrganize(ref);
  showOrganizeNotification(errors, total);
  if (ref.watch(isSaveLogProvider)) {
    await removeLogCache(S.current.organizeLogs);
  }
}

void clearOrganize(WidgetRef ref) {
  ref.read(currentProgressFileProvider.notifier).clear();
  ref.read(currentSizeProvider.notifier).clear();
  ref.read(isApplyingProvider.notifier).finish();
}

Future<List<InfoDetail>> normalOrganize(
    WidgetRef ref, List<FileInfo> list) async {
  List<InfoDetail> errorList = [];
  String targetFolder = ref.watch(folderControllerProvider).text;
  for (FileInfo file in list) {
    InfoDetail? info = await organize(ref, file, targetFolder);
    if (info != null) errorList.add(info);
  }
  return errorList;
}

Future<List<InfoDetail>> ruleOrganize(
    WidgetRef ref, List<FileInfo> list, RuleTypeValue rule) async {
  List<InfoDetail> errorList = [];
  // 检测 rule 中至少有一个不为空
  for (FileInfo file in list) {
    String folder = file.parent;
    if (rule.image != '' && file.type.isImage) folder = rule.image;
    if (rule.video != '' && file.type.isVideo) folder = rule.video;
    if (rule.audio != '' && file.type.isAudio) folder = rule.audio;
    if (rule.doc != '' && file.type.isDoc) folder = rule.doc;
    if (rule.zip != '' && file.type.isZip) folder = rule.zip;
    if (rule.folder != '' && file.type.isFolder) folder = rule.folder;
    if (rule.other != '' && file.type.isOther) folder = rule.other;
    InfoDetail? info = await organize(ref, file, folder);
    if (info != null) errorList.add(info);
  }
  return errorList;
}

Future<List<InfoDetail>> topParentsOrganize(
    WidgetRef ref, List<FileInfo> list) async {
  List<InfoDetail> errorList = [];
  for (FileInfo file in list) {
    String targetFolder = getTopPath(file.filePath);
    if (file.parent == targetFolder) continue;
    InfoDetail? info = await organize(ref, file, targetFolder);
    if (info != null) errorList.add(info);
  }
  return errorList;
}

Future<List<InfoDetail>> dateClassifyOrganize(
    WidgetRef ref, List<FileInfo> list) async {
  List<InfoDetail> errorList = [];
  String inputFolder = ref.watch(folderControllerProvider).text;
  for (FileInfo file in list) {
    String dateDir = formatDateTime(file.createdDate).substring(0, 8);
    String targetFolder = path.join(inputFolder, dateDir);
    InfoDetail? info = await organize(ref, file, targetFolder);
    if (info != null) errorList.add(info);
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
  int totalSize = await calculateSize(oldPath);
  ProgressFileInfo info = ProgressFileInfo(
    name: path.basename(oldPath),
    size: totalSize,
    transferred: 0,
  );
  InfoDetail? infoDetail;
  try {
    final parentDir = Directory(path.dirname(newPath));
    if (!await parentDir.exists()) await parentDir.create(recursive: true);
    ref.read(currentProgressFileProvider.notifier).update(info);
    if (file.type.isFolder) {
      if (isSame) {
        await Directory(oldPath).rename(newPath);
        ref
            .read(currentProgressFileProvider.notifier)
            .update(info.copyWith(transferred: totalSize));
      } else {
        await moveDirectory(ref, oldPath, newPath, info);
      }
    } else {
      if (isSame) {
        await File(oldPath).rename(newPath);
      } else {
        await moveFileWithProgress(oldPath, newPath, ref);
        await File(oldPath).delete();
      }
    }
    if (ref.watch(isSaveLogProvider)) await tempSaveLog(ref, oldPath, newPath);
    String parent = path.dirname(newPath);
    ref.read(fileListProvider.notifier).updateFileParent(file.id, parent);
    ref.read(fileListProvider.notifier).updateFilePath(file.id, newPath);
  } catch (e) {
    ref
        .read(currentProgressFileProvider.notifier)
        .update(info.copyWith(transferred: info.size));
    infoDetail = moveErrorInfo(e, isSame, oldPath, newPath);
  }
  ref.read(countProvider.notifier).update();
  return infoDetail;
}

// 查看文件夹下是否有文件，有就移动自身及所有文件到新文件夹
// 没有就移动自身
Future<void> moveDirectory(WidgetRef ref, String oldFolder, String newFolder,
    ProgressFileInfo info) async {
  // 先创建所有目录结构
  final entities = await Directory(oldFolder).list(recursive: true).toList();

  // 优先处理目录创建（确保父目录存在）
  for (var dir in entities.whereType<Directory>()) {
    final dirRelative = path.relative(dir.path, from: oldFolder);
    final newDirPath = path.join(newFolder, dirRelative);
    await Directory(newDirPath).create(recursive: true);
  }

  // 再处理文件移动
  int size = 0;
  for (var file in entities.whereType<File>()) {
    final fileRelative = path.relative(file.path, from: oldFolder);
    final newFilePath = path.join(newFolder, fileRelative);

    final verifiedPath = await renameExistFile(newFilePath);
    await moveFileWithProgress(file.path, verifiedPath, ref, size);
    await file.delete();
    size += await File(verifiedPath).length();
  }

  // 最后删除原目录
  await Directory(oldFolder).delete(recursive: true);
}

Future<void> moveFileWithProgress(String oldPath, String newPath, WidgetRef ref,
    [int? size]) async {
  const chunkSize = 1024 * 1024; // 1MB 分块
  final input = File(oldPath).openRead();
  final output = File(newPath).openWrite();
  int copied = 0;
  ProgressFileInfo? pf = ref.watch(currentProgressFileProvider);
  await for (final chunk in input) {
    output.add(chunk);
    copied += chunk.length;
    int currentCopied = copied;
    if (size != null) currentCopied = size + copied;
    ProgressFileInfo info = pf!.copyWith(transferred: currentCopied);
    ref.read(currentProgressFileProvider.notifier).update(info);
    ref.read(currentSizeProvider.notifier).update(chunk.length);
    if (copied % chunkSize == 0) await Future.delayed(Duration.zero);
  }
  await output.close();
}
