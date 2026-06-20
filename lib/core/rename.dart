import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/notification.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/src/rust/api/models.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/util/log.dart';
import 'package:once_power/util/notification.dart';
import 'package:once_power/util/storage.dart';
import 'package:path/path.dart' as path;

Future<void> runRename(WidgetRef ref, [bool isUndo = false]) async {
  List<FileInfo> allFiles = ref.read(sortListProvider);
  List<FileInfo> list = allFiles.where((e) => e.checked).toList();
  if (list.isEmpty) return;
  Stopwatch stopwatch = Stopwatch()..start();
  int total = list.length;
  List<InfoDetail> errs = [];
  bool saveLog = ref.read(isSaveLogProvider);
  bool cancelEmptyRename = StorageUtil.getBool(AppKeys.cancelEmptyRename);
  if (saveLog) LogServer.init();
  ref.read(countProvider.notifier).reset();
  ref.read(totalProvider.notifier).update(total);
  ref.read(isApplyingProvider.notifier).start();
  final provider = ref.read(fileListProvider.notifier);
  // ================= Start =================
  final Map<String, int> pathMap = {};
  Set<FileInfo> errFiles = {};
  for (FileInfo file in list) {
    if (file.newPath(isUndo: isUndo) == file.path) continue;
    if (cancelEmptyRename && file.newName.isEmpty) continue;
    String tempPath = generateTempName(file),
        newPath = file.newPath(isUndo: isUndo);
    InfoDetail? info = await renameFile(
      file.fileType.isFolder,
      file.path,
      tempPath,
      realNewPath: newPath,
    );
    if (info != null) {
      errs.add(info);
      errFiles.add(file);
    }
    provider.updateTempPath(file.id, tempPath);
  }

  final cProvider = ref.read(countProvider.notifier);
  for (FileInfo file in list) {
    cProvider.update();
    if (file.newPath(isUndo: isUndo) == file.path) continue;
    if (cancelEmptyRename && file.newName.isEmpty) continue;
    if (errFiles.contains(file)) continue;
    bool isFolder = file.fileType.isFolder;
    String oldPath = file.tempPath, newPath = file.newPath(isUndo: isUndo);
    bool isExist = await checkExist(isFolder, newPath);
    if (isExist) {
      int counter = pathMap[newPath] ?? 1;
      final result = await generateExistName(file, counter);
      pathMap[newPath] = result.$2;
      newPath = result.$1;
    }
    InfoDetail? info = await renameFile(
      isFolder,
      oldPath,
      newPath,
      realOldPath: file.path,
    );
    if (info != null) {
      errs.add(info);
      await renameFile(isFolder, oldPath, file.path);
      provider.updateTempPath(file.id, '');
    } else {
      updateShowInfo(provider, file, newPath);
    }
  }
  // ================== End ==================
  stopwatch.stop();
  double cost = stopwatch.elapsedMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  ref.read(isApplyingProvider.notifier).finish();
  ref.read(showUndoProvider.notifier).update(!isUndo);
  isUndo
      ? showUndoNotification(errs, total)
      : showRenameNotification(errs, total);
  updateName(ref);
  if (saveLog) await LogServer.create();
}

Future<bool> checkExist(bool isFolder, String path) async =>
    isFolder ? Directory(path).exists() : File(path).exists();

Future<(String, int)> generateExistName(FileInfo file, int counter) async {
  String name = file.newName, finalPath = '';
  bool isFolder = file.fileType.isFolder;
  String prefix = StorageUtil.getString(AppKeys.autoPrefix) ?? '_';
  int width = StorageUtil.getInt(AppKeys.autoWidth) ?? 2;
  String suffix = StorageUtil.getString(AppKeys.autoSuffix) ?? '';
  while (true) {
    name = '$name$prefix${formatNum(counter, width)}$suffix';
    String newPath = getFullName(name, file.newExt);
    finalPath = path.join(file.parent, newPath);
    counter++;
    if (!await checkExist(isFolder, finalPath)) break;
  }
  return (finalPath, counter);
}

String generateTempName(FileInfo file) {
  String temp =
      '${file.name}.${removeForbiddenCharacters(file.id)}.${DateTime.now().millisecondsSinceEpoch}.once-power.tmp';
  String tempName = getFullName(temp, file.ext);
  return path.join(file.parent, tempName);
}

Future<InfoDetail?> renameFile(
  bool isFolder,
  String oldPath,
  String newPath, {
  String realOldPath = '',
  String realNewPath = '',
}) async {
  try {
    if (isFolder) {
      await Directory(oldPath).rename(newPath);
    } else {
      await File(oldPath).rename(newPath);
    }
    return null;
  } on FileSystemException catch (e) {
    oldPath = realOldPath.isEmpty ? oldPath : realOldPath;
    newPath = realNewPath.isEmpty ? newPath : realNewPath;
    return renameErrorNotification(e, oldPath, newPath);
  }
}

void updateShowInfo(FileList provider, FileInfo file, String newPath) {
  String id = file.id;
  String newName = path.basenameWithoutExtension(newPath);
  String newExt = path.extension(newPath);

  if (newExt.isEmpty && newName.startsWith('.')) {
    (newName, newExt) = ('', newName.substring(1));
  }

  provider.updateOriginName(id, newName);
  newExt = newExt.isEmpty ? '' : newExt.substring(1);
  if (file.ext != newExt) provider.updateOriginExtension(id, newExt);
  provider.updatePath(id, newPath);
  if (file.tempPath.isNotEmpty) provider.updateTempPath(id, '');
}
