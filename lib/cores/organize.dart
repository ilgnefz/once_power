import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/oplog.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/models/progress.dart';
import 'package:once_power/models/type.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/utils/verify.dart';
import 'package:path/path.dart' as path;

import 'notification.dart';

Future<void> targetFolderCache(String folder, String key) async {
  List<String> list = StorageUtil.getStringList(key);
  if (list.contains(folder)) list.remove(folder);
  list.add(folder);
  await StorageUtil.setStringList(key, list);
}

void organizeFolder(WidgetRef ref) async {
  List<FileInfo> list = ref.watch(fileListProvider);
  List<FileInfo> checkList = list.where((e) => e.checked).toList();
  int total = checkList.length;
  if (checkList.isEmpty) return;
  ref.read(totalProvider.notifier).update(total);
  ref.read(countProvider.notifier).reset();
  ref.read(isApplyingProvider.notifier).start();
  List<InfoDetail> errors = [];
  DateTime startTime = DateTime.now();
  bool isGroup = ref.watch(useGroupOrganizeProvider);
  bool isRule = ref.watch(useTypeOrganizeProvider);
  bool isTop = ref.watch(useTopFolderProvider);
  if (!isRule && !isTop && !isGroup) {
    String inputFolder = ref.watch(folderControllerProvider).text;
    if (inputFolder == '' || inputFolder.isEmpty) {
      clearOrganize(ref);
      return showOrganizeEmptyNotification();
    }
  }
  if (isGroup) {
    Map<String, String>? folders = StorageUtil.getStringMap(
      AppKeys.groupFolder,
    );
    if (folders == null || folders.isEmpty) {
      clearOrganize(ref);
      return showOrganizeNullNotification(tr(AppL10n.errGroupFolder));
    }
    errors.addAll(await groupOrganize(ref, checkList, folders));
  } else if (isRule) {
    RuleTypeValue? rule = StorageUtil.getRuleTypeValue(AppKeys.ruleTypeValue);
    if (rule == null || rule.isEmpty()) {
      clearOrganize(ref);
      return showOrganizeNullNotification(tr(AppL10n.errTypeFolder));
    }
    errors.addAll(await ruleOrganize(ref, checkList, rule));
  } else if (isTop) {
    errors.addAll(await topParentsOrganize(ref, checkList));
  } else if (ref.watch(useDateOrganizeProvider)) {
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
    await removeLogCache(tr(AppL10n.logOrganize));
  }
}

void clearOrganize(WidgetRef ref) {
  ref.read(currentProgressFileProvider.notifier).clear();
  ref.read(currentSizeProvider.notifier).clear();
  ref.read(isApplyingProvider.notifier).finish();
}

Future<List<InfoDetail>> normalOrganize(
  WidgetRef ref,
  List<FileInfo> list,
) async {
  List<InfoDetail> errorList = [];
  String targetFolder = ref.watch(folderControllerProvider).text;
  for (FileInfo file in list) {
    InfoDetail? info = await organize(ref, file, targetFolder);
    if (info != null) errorList.add(info);
  }
  return errorList;
}

Future<List<InfoDetail>> groupOrganize(
  WidgetRef ref,
  List<FileInfo> list,
  Map<String, String> folders,
) async {
  List<InfoDetail> errorList = [];
  for (FileInfo file in list) {
    String folder = file.parent;
    if (folders.containsKey(file.group)) {
      if (folders[file.group] == '') continue;
      folder = folders[file.group]!;
    }
    InfoDetail? info = await organize(ref, file, folder);
    if (info != null) errorList.add(info);
  }
  return errorList;
}

Future<List<InfoDetail>> ruleOrganize(
  WidgetRef ref,
  List<FileInfo> list,
  RuleTypeValue rule,
) async {
  List<InfoDetail> errorList = [];
  for (FileInfo file in list) {
    String folder = file.parent;
    if (rule.image != '' && file.type.isImage) folder = rule.image;
    if (rule.video != '' && file.type.isVideo) folder = rule.video;
    if (rule.audio != '' && file.type.isAudio) folder = rule.audio;
    if (rule.doc != '' && file.type.isDoc) folder = rule.doc;
    if (rule.archive != '' && file.type.isArchive) folder = rule.archive;
    if (rule.folder != '' && file.type.isFolder) folder = rule.folder;
    if (rule.other != '' && file.type.isOther) folder = rule.other;
    InfoDetail? info = await organize(ref, file, folder);
    if (info != null) errorList.add(info);
  }
  return errorList;
}

Future<List<InfoDetail>> topParentsOrganize(
  WidgetRef ref,
  List<FileInfo> list,
) async {
  List<InfoDetail> errorList = [];
  for (FileInfo file in list) {
    String targetFolder = getTopPath(file.path);
    if (file.parent == targetFolder) continue;
    InfoDetail? info = await organize(ref, file, targetFolder);
    if (info != null) errorList.add(info);
  }
  return errorList;
}

Future<List<InfoDetail>> dateClassifyOrganize(
  WidgetRef ref,
  List<FileInfo> list,
) async {
  List<InfoDetail> errorList = [];
  String inputFolder = ref.watch(folderControllerProvider).text;
  for (FileInfo file in list) {
    String dateDir = formatDateTime(file.createdDate.date).substring(0, 8);
    String targetFolder = path.join(inputFolder, dateDir);
    InfoDetail? info = await organize(ref, file, targetFolder);
    if (info != null) errorList.add(info);
  }
  return errorList;
}

Future<String> renameExistFile(String newPath) async {
  int counter = 1;
  final String dir = path.dirname(newPath);
  final String ext = path.extension(newPath);
  final String baseName = path.basenameWithoutExtension(newPath);
  while (true) {
    bool isExist = await File(newPath).exists();
    if (Platform.isWindows) isExist = isExist && await isTrueExist(newPath);
    if (!isExist) break;
    final String newFileName = '${baseName}_${formatNum(counter, 2)}$ext';
    newPath = path.join(dir, newFileName);
    counter++;
    if (counter > 1000) throw Exception('无法生成可用文件名');
  }
  return newPath;
}

Future<InfoDetail?> organize(
  WidgetRef ref,
  FileInfo file,
  String folder,
) async {
  String oldPath = file.path;
  String newPath = path.join(folder, path.basename(oldPath));
  newPath = await renameExistFile(newPath);
  bool isSame = isSameDisk(oldPath, newPath);
  int totalSize = file.size;
  ProgressFileInfo info = ProgressFileInfo(
    name: path.basename(oldPath),
    size: totalSize,
    transferred: 0,
  );
  InfoDetail? infoDetail;
  try {
    // 提取目录创建逻辑为辅助函数（减少重复代码）
    await ensureParentDirExists(newPath);
    // 更新进度状态（公共操作）
    ref.read(currentProgressFileProvider.notifier).update(info);
    // 分情况处理文件/文件夹移动（逻辑清晰化）
    if (file.type.isFolder) {
      await handleFolderMove(ref, oldPath, newPath, isSame, info);
    } else {
      await handleFileMove(ref, oldPath, newPath, isSame);
    }
    // 记录日志、更新文件信息（公共操作）
    if (ref.watch(isSaveLogProvider)) await tempSaveLog(ref, oldPath, newPath);
    updateFileInfoAfterMove(ref, file, newPath);
  } catch (e) {
    // 统一错误处理
    ref
        .read(currentProgressFileProvider.notifier)
        .update(info.copyWith(transferred: info.size));
    infoDetail = moveErrorNotification(e, isSame, oldPath, newPath);
  }
  ref.read(countProvider.notifier).update();
  return infoDetail;
}

// 辅助函数：确保父目录存在
Future<void> ensureParentDirExists(String newPath) async {
  final parentDir = Directory(path.dirname(newPath));
  if (!await parentDir.exists()) await parentDir.create(recursive: true);
}

// 辅助函数：处理文件夹移动
Future<void> handleFolderMove(
  WidgetRef ref,
  String oldPath,
  String newPath,
  bool isSame,
  ProgressFileInfo info,
) async {
  if (isSame) {
    await Directory(oldPath).rename(newPath);
    ref
        .read(currentProgressFileProvider.notifier)
        .update(info.copyWith(transferred: info.size));
  } else {
    await moveDirectory(ref, oldPath, newPath, info);
  }
}

// 辅助函数：处理文件移动
Future<void> handleFileMove(
  WidgetRef ref,
  String oldPath,
  String newPath,
  bool isSame,
) async {
  if (isSame) {
    await File(oldPath).rename(newPath);
  } else {
    await moveFileWithProgress(oldPath, newPath, ref);
    await File(oldPath).delete();
  }
}

// 辅助函数：更新文件信息
void updateFileInfoAfterMove(WidgetRef ref, FileInfo file, String newPath) {
  String parent = path.dirname(newPath);
  ref.read(fileListProvider.notifier).updateFolder(file.id, parent);
  ref.read(fileListProvider.notifier).updatePath(file.id, newPath);
}

// 查看文件夹下是否有文件，有就移动自身及所有文件到新文件夹
// 没有就移动自身
Future<void> moveDirectory(
  WidgetRef ref,
  String oldFolder,
  String newFolder,
  ProgressFileInfo info,
) async {
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

Future<void> moveFileWithProgress(
  String oldPath,
  String newPath,
  WidgetRef ref, [
  int? size,
]) async {
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
