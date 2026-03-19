import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/enum/organize.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/model/notification.dart';
import 'package:once_power/model/progress.dart';
import 'package:once_power/model/type.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/src/rust/api/simple.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/util/notification.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/util/verify.dart';
import 'package:path/path.dart' as path;

import 'list.dart';

List<InfoDetail> _errorList = [];
Map<String, int> _duplicateMap = {};

Future<void> organize(WidgetRef ref) async {
  List<FileInfo> allFiles = ref.read(sortListProvider);
  List<FileInfo> list = allFiles.where((e) => e.checked).toList();
  if (list.isEmpty) return;
  Stopwatch stopwatch = Stopwatch()..start();
  _errorList.clear();
  _duplicateMap.clear();
  int total = list.length;
  ref.read(countProvider.notifier).reset();
  ref.read(totalProvider.notifier).update(total);
  ref.read(isApplyingProvider.notifier).start();
  OrganizeMode mode = ref.read(currentOrganizeModeProvider);
  Set<String> errFolders = {};
  String folder = '';
  switch (mode) {
    case OrganizeMode.normal:
      folder = ref.read(folderControllerProvider).text;
      if (folder.isEmpty) {
        ref.read(isApplyingProvider.notifier).finish();
        return showOrganizeNullNotification(tr(AppL10n.errTargetFolder));
      }
      for (FileInfo file in list) {
        InfoDetail? err = await moveFile(ref, file, folder, errFolders);
        if (err != null) _errorList.add(err);
      }
      break;
    case OrganizeMode.group:
      Map<String, String>? folders = StorageUtil.getStringMap(
        AppKeys.groupFolder,
      );
      if (folders == null || folders.values.every((path) => path.isEmpty)) {
        ref.read(isApplyingProvider.notifier).finish();
        return showOrganizeNullNotification(tr(AppL10n.errGroupFolder));
      }
      for (FileInfo file in list) {
        if (file.group == '') continue;
        if (folders.containsKey(file.group)) folder = folders[file.group]!;
        InfoDetail? err = await moveFile(ref, file, folder, errFolders);
        if (err != null) _errorList.add(err);
      }
      break;
    case OrganizeMode.type:
      RuleTypeValue? rule = StorageUtil.getRuleTypeValue(AppKeys.ruleTypeValue);
      if (rule == null || RuleTypeValue.allPropertiesEmpty(rule)) {
        ref.read(isApplyingProvider.notifier).finish();
        return showOrganizeNullNotification(tr(AppL10n.errTypeFolder));
      }
      for (FileInfo file in list) {
        if (file.type == FileType.image) folder = rule.image;
        if (file.type == FileType.folder) folder = rule.folder;
        if (file.type == FileType.video) folder = rule.video;
        if (file.type == FileType.doc) folder = rule.doc;
        if (file.type == FileType.audio) folder = rule.audio;
        if (file.type == FileType.other) folder = rule.other;
        if (file.type == FileType.archive) folder = rule.archive;
        InfoDetail? err = await moveFile(ref, file, folder, errFolders);
        if (err != null) _errorList.add(err);
      }
      break;
    case OrganizeMode.top:
      for (FileInfo file in list) {
        folder = getTopPath(file.path);
        InfoDetail? err = await moveFile(ref, file, folder, errFolders);
        if (err != null) _errorList.add(err);
      }
      break;
    case OrganizeMode.date:
      String fatherFolder = ref.watch(folderControllerProvider).text;
      for (FileInfo file in list) {
        String dateDir = organizeDateFolder(ref, file);
        if (fatherFolder.isEmpty) fatherFolder = file.parent;
        String folder = path.join(fatherFolder, dateDir);
        InfoDetail? err = await moveFile(ref, file, folder, errFolders);
        if (err != null) _errorList.add(err);
      }
      break;
  }
  ref.read(currentProgressFileProvider.notifier).clear();
  stopwatch.stop();
  double cost = stopwatch.elapsedMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  ref.read(isApplyingProvider.notifier).finish();
  showOrganizeNotification(_errorList, total);
}

Future<InfoDetail?> moveFile(
  WidgetRef ref,
  FileInfo file,
  String folder,
  Set<String> errFolders,
) async {
  if (errFolders.contains(folder)) return null;
  String normalizedFolder = path.normalize(folder);
  if (folder == '' || path.equals(normalizedFolder, file.parent)) return null;
  try {
    bool folderExist = await Directory(folder).exists();
    if (!folderExist) await Directory(folder).create(recursive: true);
  } catch (e) {
    errFolders.add(folder);
    return InfoDetail(
      file: folder,
      message: '${tr(AppL10n.errCreateFolder)}: ${formatSystemError(e)}',
    );
  }
  String oldPath = file.path;
  String newPath = path.join(folder, file.getFullOldName());
  bool exist = await File(newPath).exists();
  if (exist) newPath = await renameExistFile(newPath);
  bool sameDisk = isSameDisk(oldPath, newPath);
  int totalSize = file.size;
  ProgressFileInfo info = ProgressFileInfo(
    name: path.basename(oldPath),
    size: totalSize,
    transferred: 0,
  );
  final progressProvider = ref.read(currentProgressFileProvider.notifier);
  progressProvider.update(info);
  InfoDetail? infoDetail = file.type.isFolder
      ? await organizeFolder(ref, file, sameDisk, oldPath, newPath)
      : await organizeFile(ref, file, sameDisk, oldPath, newPath);
  progressProvider.update(info.copyWith(transferred: info.size));
  ref.read(countProvider.notifier).update();
  return infoDetail;
}

void updateInfo(WidgetRef ref, FileInfo file, String newPath) {
  final provider = ref.read(fileListProvider.notifier);
  String parent = path.dirname(newPath);
  String newName = path.basenameWithoutExtension(newPath);
  if (newName != file.name) provider.updateOriginName(file.id, newName);
  provider.updateFolder(file.id, parent);
  provider.updatePath(file.id, newPath);
}

Future<InfoDetail?> organizeFile(
  WidgetRef ref,
  FileInfo file,
  bool sameDisk,
  String oldPath,
  String newPath,
) async {
  try {
    File? newFile;
    if (sameDisk) {
      newFile = await File(oldPath).rename(newPath);
      // 更新进度
      ref.read(currentSizeProvider.notifier).update(file.size);
    } else {
      // 使用带进度的文件传输
      await moveFileWithProgress(ref, oldPath, newPath);
      await File(oldPath).delete();
      newFile = File(newPath);
    }
    updateInfo(ref, file, newFile.absolute.path);
    return null;
  } catch (e) {
    return moveErrorNotification(formatSystemError(e), oldPath, newPath);
  }
}

// 带进度的文件传输方法
Future<void> moveFileWithProgress(
  WidgetRef ref,
  String oldPath,
  String newPath,
) async {
  const chunkSize = 1024 * 1024; // 1MB 分块
  final input = File(oldPath).openRead();
  final output = File(newPath).openWrite();
  int copied = 0;
  ProgressFileInfo? pf = ref.read(currentProgressFileProvider);

  await for (final chunk in input) {
    output.add(chunk);
    copied += chunk.length;

    // 更新文件传输进度
    if (pf != null) {
      ProgressFileInfo info = pf.copyWith(transferred: copied);
      ref.read(currentProgressFileProvider.notifier).update(info);
    }

    // 更新总进度
    ref.read(currentSizeProvider.notifier).update(chunk.length);

    // 每1MB更新一次UI
    if (copied % chunkSize == 0) {
      await Future.delayed(Duration.zero);
    }
  }

  await output.close();
}

Future<InfoDetail?> organizeFolder(
  WidgetRef ref,
  FileInfo file,
  bool sameDisk,
  String oldPath,
  String newPath,
) async {
  try {
    Directory dir;
    if (sameDisk) {
      dir = await Directory(oldPath).rename(newPath);
      // 更新进度
      ref.read(currentSizeProvider.notifier).update(file.size);
    } else {
      dir = await Directory(newPath).create(recursive: true);
      bool flag = await moveFolderChildWithProgress(ref, oldPath, newPath);
      if (flag) {
        await Directory(oldPath).delete();
      } else {
        return InfoDetail(file: oldPath, message: tr(AppL10n.errPartMove));
      }
    }
    updateInfo(ref, file, dir.absolute.path);
    return null;
  } catch (e) {
    return moveErrorNotification(formatSystemError(e), oldPath, newPath);
  }
}

Future<bool> moveFolderChildWithProgress(
  WidgetRef ref,
  String oldPath,
  String newPath,
) async {
  bool flag = true;
  Directory dir = Directory(oldPath);
  List<FileSystemEntity> list = await dir.list().toList();
  for (FileSystemEntity entity in list) {
    String targetPath = path.join(newPath, path.basename(entity.path));
    try {
      if (entity is File) {
        // 使用带进度的文件传输
        await moveFileWithProgress(ref, entity.path, targetPath);
        await entity.delete();
      } else {
        await Directory(targetPath).create(recursive: true);
        bool childFlag = await moveFolderChildWithProgress(
          ref,
          entity.path,
          targetPath,
        );
        childFlag ? await entity.delete() : flag = false;
      }
    } catch (e) {
      flag = false;
    }
  }
  return flag;
}

Future<String> renameExistFile(String filePath) async {
  String folder = path.dirname(filePath);
  String name = path.basenameWithoutExtension(filePath);
  String extension = path.extension(filePath);
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
  return path.join(
    folder,
    '$name$prefix${formatNum(counter, width)}.$extension',
  );
}

Future<void> deleteSelected(WidgetRef ref) async {
  _errorList.clear();
  List<String> deletePaths = [];
  List<FileInfo> files = ref.read(sortListProvider);
  for (FileInfo file in files) {
    if (!file.checked) continue;
    removeOne(ref, file);
    deletePaths.add(file.path);
  }
  try {
    await deleteAllToTrash(filePaths: deletePaths);
  } catch (e) {
    _errorList.add(
      InfoDetail(
        file: tr(AppL10n.errDelete),
        message: '${tr(AppL10n.errDelete)}: $e',
      ),
    );
  }
  showDeleteNotification(_errorList, false);
}

Future<void> deleteEmptyFolder(WidgetRef ref) async {
  _errorList.clear();
  List<FileInfo> files = ref.read(fileListProvider);
  for (FileInfo file in files) {
    if (!file.checked) continue;
    if (!file.type.isFolder) continue;
    deleteFolders(file.path);
  }
  showDeleteNotification(_errorList);
}

Future<void> deleteFile(Directory directory) async {
  try {
    await deleteToTrash(filePath: directory.path);
  } catch (e) {
    _errorList.add(
      InfoDetail(file: directory.path, message: '${tr(AppL10n.errDelete)}: $e'),
    );
  }
}

Future<void> deleteFolders(String folderPath) async {
  var directory = Directory(folderPath);
  if (await directory.exists()) {
    final entities = await directory.list().toList();
    // 检查初始空目录
    if (entities.isEmpty) return await deleteFile(directory);
    // 异步递归处理子目录
    await for (final entity in directory.list(recursive: false)) {
      if (await FileSystemEntity.isDirectory(entity.path)) {
        await deleteFolders(entity.path);
      }
    }
    // 处理完子项后重新检查目录是否为空
    final remainingEntities = await directory.list().toList();
    if (remainingEntities.isEmpty) await deleteFile(directory);
  }
}
