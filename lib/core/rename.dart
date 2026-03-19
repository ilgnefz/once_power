import 'dart:io';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart' show AppL10n;
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/model/notification.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/util/notification.dart';
import 'package:once_power/util/log.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/util/verify.dart';
import 'package:path/path.dart' as path;

Map<String, int> _duplicateMap = {};

Future<void> runRename(WidgetRef ref, [bool isUndo = false]) async {
  List<FileInfo> allFiles = ref.read(sortListProvider);
  List<FileInfo> list = allFiles.where((e) => e.checked).toList();
  if (list.isEmpty) return;
  Stopwatch stopwatch = Stopwatch()..start();
  int total = list.length;
  List<InfoDetail> errs = [];
  _duplicateMap.clear();
  bool saveLog = ref.read(isSaveLogProvider);
  bool cancelEmptyRename = StorageUtil.getBool(AppKeys.cancelEmptyRename);
  if (saveLog) LogServer.init();
  ref.read(countProvider.notifier).reset();
  ref.read(totalProvider.notifier).update(total);
  ref.read(isApplyingProvider.notifier).start();
  List<FileInfo> tempList = List.from(list);
  for (FileInfo file in list) {
    tempList.removeAt(0);
    if (file.path == file.getNewPath(isUndo)) continue;
    if (cancelEmptyRename && file.newName.isEmpty) continue;
    InfoDetail? info = await handelFile(ref, tempList, file, isUndo, saveLog);
    if (info != null) errs.add(info);
    ref.read(countProvider.notifier).update();
  }
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

Future<String> renameExistFile(String filePath) async {
  String folder = path.dirname(filePath);
  String name = path.basenameWithoutExtension(filePath);
  String extension = path.extension(filePath);
  if (extension.isEmpty && name.startsWith('.')) {
    (name, extension) = ('', name);
  }
  String duplicateKey = Platform.isLinux
      ? path.join(folder, name + extension.toLowerCase())
      : filePath.toLowerCase();
  int counter = 1;
  if (_duplicateMap.containsKey(duplicateKey)) {
    counter = _duplicateMap[duplicateKey] ?? 2;
    _duplicateMap[duplicateKey] = counter + 1;
  } else {
    _duplicateMap[duplicateKey] = 2;
  }
  String prefix = StorageUtil.getString(AppKeys.autoPrefix) ?? '_';
  int width = StorageUtil.getInt(AppKeys.autoWidth) ?? 2;
  String suffix = StorageUtil.getString(AppKeys.autoSuffix) ?? '';
  String newPath = path.join(
    folder,
    '$name$prefix${formatNum(counter, width)}$suffix$extension',
  );
  if (await isExist(false, newPath)) return renameExistFile(newPath);
  return newPath;
}

Future<InfoDetail?> handelFile(
  WidgetRef ref,
  List<FileInfo> list,
  FileInfo file,
  bool isUndo,
  bool saveLog,
) async {
  // print('${file.path} -- ${file.tempPath} -- ${file.getNewPath()}');
  Set<String> pendingFiles = {};
  RenameCondition condition = await checkCondition(
    ref,
    file,
    list,
    pendingFiles,
    isUndo,
  );
  String newPath = file.getNewPath(isUndo);
  if (condition.isBlocked) {
    if (StorageUtil.getBool(AppKeys.autoRename)) {
      newPath = await renameExistFile(newPath);
    } else {
      return InfoDetail(
        file: file.getFullOldName(),
        message:
            ' ${tr(AppL10n.errExists, namedArgs: {'name': file.getFullNewName()})}',
      );
    }
  }
  bool isFolder = file.type.isFolder;
  String oldPath = file.tempPath.isEmpty ? file.path : file.tempPath;
  InfoDetail? err = await renameFile(isFolder, oldPath, newPath);
  if (err == null) {
    if (saveLog) LogServer.add(logInfo(file.path, newPath));
    updateShowInfo(ref, file, newPath);
    return null;
  }
  return err;
}

Future<RenameCondition> checkCondition(
  WidgetRef ref,
  FileInfo file,
  List<FileInfo> list,
  Set<String> pendingFiles,
  bool isUndo,
) async {
  String newPath = file.getNewPath(isUndo);
  // 检测是否存在，如果不存在就返回 available
  if (await isExist(false, newPath)) {
    FileInfo? tempFile = list.firstWhereOrNull((e) => e.path == newPath);
    if (tempFile == null) return RenameCondition.blocked;
    if (pendingFiles.contains(tempFile.id)) return RenameCondition.override;
    pendingFiles.add(file.id);
    RenameCondition res = await checkCondition(
      ref,
      tempFile,
      list,
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
  String tempName = getFullName(temp, file.newExtension);
  return path.join(file.parent, tempName);
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
  String newName = path.basenameWithoutExtension(newPath);
  String newExt = path.extension(newPath);
  if (newExt.isEmpty && newName.startsWith('.')) {
    (newName, newExt) = ('', newName.substring(1));
  }
  provider.updateOriginName(id, newName);
  newExt = newExt.isEmpty ? '' : newExt.substring(1);
  if (file.extension != newExt) provider.updateOriginExtension(id, newExt);
  provider.updatePath(id, newPath);
  if (file.tempPath.isNotEmpty) provider.updateTempPath(id, '');
}
