import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart' show AppL10n;
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/model/notification.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/util/notification.dart';
import 'package:once_power/util/log.dart';
import 'package:once_power/util/verify.dart';
import 'package:path/path.dart';

Future<void> runRename(WidgetRef ref, [bool isUndo = false]) async {
  Stopwatch stopwatch = Stopwatch()..start();
  List<FileInfo> allFiles = ref.read(sortListProvider);
  List<FileInfo> list = allFiles.where((e) => e.checked).toList();
  Set<String> allPath = list.map((e) => e.path).toSet();
  int total = list.length;
  List<InfoDetail> errs = [];
  bool saveLog = ref.read(isSaveLogProvider);
  if (saveLog) LogServer.init();
  ref.read(countProvider.notifier).reset();
  ref.read(totalProvider.notifier).update(total);
  for (FileInfo file in list) {
    if (!file.checked) continue;
    if (file.path == file.getNewPath(isUndo)) continue;
    InfoDetail? info = await handelFile(ref, list, allPath, file, isUndo);
    if (info == null) {
      String newPath = file.getNewPath(isUndo);
      if (saveLog) LogServer.add(logInfo(file.path, newPath));
      updateShowInfo(ref, file, newPath);
    } else {
      errs.add(info);
    }
    ref.read(countProvider.notifier).update();
  }
  stopwatch.stop();
  double cost = stopwatch.elapsedMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  ref.read(showUndoProvider.notifier).update(!isUndo);
  isUndo
      ? showUndoNotification(errs, total)
      : showRenameNotification(errs, total);
  updateName(ref);
  if (saveLog) await LogServer.create();
}

Future<InfoDetail?> handelFile(
  WidgetRef ref,
  List<FileInfo> list,
  Set<String> allPath,
  FileInfo file,
  bool isUndo,
) async {
  // print('${file.path} -- ${file.tempPath} -- ${file.getNewPath()}');
  Set<String> pendingFiles = {};
  RenameCondition condition = await checkCondition(
    ref,
    file,
    list,
    allPath,
    pendingFiles,
    isUndo,
  );
  if (condition.isBlocked) {
    return InfoDetail(
      file: file.getFullOldName(),
      message:
          ' ${tr(AppL10n.errExists, namedArgs: {'name': file.getFullNewName()})}',
    );
  } else if (condition.isAvailable) {
    bool isFolder = file.type.isFolder;
    String oldPath = file.tempPath.isEmpty ? file.path : file.tempPath;
    String newPath = file.getNewPath(isUndo);
    return renameFile(isFolder, oldPath, newPath);
  }
  return null;
}

Future<RenameCondition> checkCondition(
  WidgetRef ref,
  FileInfo file,
  List<FileInfo> list,
  Set<String> allPath,
  Set<String> pendingFiles,
  bool isUndo,
) async {
  String newPath = file.getNewPath(isUndo);
  // 检测是否存在，如果不存在就返回 available
  if (await isExist(false, newPath)) {
    //   查看是否在路径中，不在就返回 blocked
    bool inList = allPath.contains(newPath);
    if (!inList) return RenameCondition.blocked;
    FileInfo tempFile = list.firstWhere((element) => element.path == newPath);
    // 查看 tempFile 的新名称是否在列表里，不是就直接重命名为新名称
    if (pendingFiles.contains(tempFile.id)) return RenameCondition.override;
    pendingFiles.add(file.id);
    RenameCondition res = await checkCondition(
      ref,
      tempFile,
      list,
      allPath,
      pendingFiles,
      isUndo,
    );
    if (res.isBlocked) return RenameCondition.blocked;
    String tempPath = res.isOverride
        ? generateTempName(tempFile)
        : tempFile.getNewPath(isUndo);
    try {
      await renameFile(tempFile.type.isFolder, tempFile.path, tempPath);
      if (res.isAvailable) {
        updateShowInfo(ref, tempFile, tempPath);
      } else if (res.isOverride) {
        ref
            .read(fileListProvider.notifier)
            .updateTempPath(tempFile.id, tempPath);
      }
      return RenameCondition.available;
    } catch (e) {
      return RenameCondition.blocked;
    }
  }
  return RenameCondition.available;
}

String generateTempName(FileInfo file) {
  String temp = '${file.name}.${DateTime.now().hashCode}.once-power.tmp';
  String tempName = getFullName(temp, file.newExt);
  return join(file.parent, tempName);
}

Future<InfoDetail?> renameFile(
  bool isFolder,
  String oldPath,
  String newPath,
) async {
  try {
    if (isFolder) {
      await Directory(oldPath).rename(newPath);
    } else {
      await File(oldPath).rename(newPath);
    }
  } on FileSystemException catch (e) {
    return renameErrorNotification(e, oldPath, newPath);
  }
  return null;
}

void updateShowInfo(WidgetRef ref, FileInfo file, String newPath) {
  String id = file.id;
  final FileList provider = ref.read(fileListProvider.notifier);
  String newName = basenameWithoutExtension(newPath);
  provider.updateOriginName(id, newName);
  String newExt = extension(newPath);
  newExt = newExt.isEmpty ? '' : newExt.substring(1);
  if (file.ext != newExt) provider.updateOriginExt(id, newExt);
  provider.updatePath(id, newPath);
  if (file.tempPath.isNotEmpty) provider.updateTempPath(id, '');
}
