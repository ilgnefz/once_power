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
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/src/rust/api/simple.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/notification.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/util/verify.dart';
import 'package:path/path.dart' as path;

import 'list.dart';

List<InfoDetail> _errorList = [];
Map<String, int> _duplicateMap = {};

Future<void> organize(WidgetRef ref) async {
  Stopwatch stopwatch = Stopwatch()..start();
  _errorList.clear();
  _duplicateMap.clear();
  List<FileInfo> allFiles = ref.read(sortListProvider);
  List<FileInfo> list = allFiles.where((e) => e.checked).toList();
  int total = list.length;
  ref.read(countProvider.notifier).reset();
  ref.read(totalProvider.notifier).update(total);
  OrganizeMode mode = ref.read(currentOrganizeModeProvider);
  switch (mode) {
    case OrganizeMode.normal:
      String folder = ref.read(folderControllerProvider).text;
      print('目标文件夹: $folder');
      for (FileInfo file in list) {
        InfoDetail? err = await moveFile(ref, file, folder);
        if (err != null) _errorList.add(err);
      }
      break;
    case OrganizeMode.group:
      // TODO: Handle this case.
      break;
    case OrganizeMode.type:
      // TODO: Handle this case.
      break;
    case OrganizeMode.top:
      // TODO: Handle this case.
      break;
    case OrganizeMode.date:
      // TODO: Handle this case.
      break;
  }

  stopwatch.stop();
  double cost = stopwatch.elapsedMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
}

Future<InfoDetail?> moveFile(
  WidgetRef ref,
  FileInfo file,
  String folder,
) async {
  String oldPath = file.path;
  String newPath = path.join(folder, file.getFullOldName());
  // 检测文件是否存在
  bool exist = await File(newPath).exists();
  if (exist) {
    newPath = await renameExistFile(newPath);
    String newName = path.basenameWithoutExtension(newPath);
    ref.read(fileListProvider.notifier).updateOriginName(file.id, newName);
  }
  bool sameDist = isSameDisk(oldPath, newPath);
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
      await handleFolderMove(ref, oldPath, newPath, sameDist, info);
    } else {
      await handleFileMove(ref, oldPath, newPath, sameDist);
    }
    // 记录日志、更新文件信息（公共操作）
    // if (ref.watch(isSaveLogProvider)) await tempSaveLog(ref, oldPath, newPath);
    updateFileInfoAfterMove(ref, file, newPath);
  } catch (e) {
    // 统一错误处理
    ref
        .read(currentProgressFileProvider.notifier)
        .update(info.copyWith(transferred: info.size));
    infoDetail = moveErrorNotification(e, sameDist, oldPath, newPath);
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
  for (Directory dir in entities.whereType<Directory>()) {
    final dirRelative = path.relative(dir.path, from: oldFolder);
    final newDirPath = path.join(newFolder, dirRelative);
    await Directory(newDirPath).create(recursive: true);
  }

  // 再处理文件移动
  int size = 0;
  for (File file in entities.whereType<File>()) {
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
  bool saveLog = ref.watch(isSaveLogProvider);
  List<String> deletePaths = [];
  List<FileInfo> files = ref.read(sortListProvider);
  for (FileInfo file in files) {
    if (!file.checked) continue;
    removeOne(ref, file);
    deletePaths.add(file.path);
    // if (saveLog) await tempSaveDeleteLog(ref, file.path);
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
  if (ref.watch(isSaveLogProvider)) {
    // await removeLogCache(tr(AppL10n.logDelete));
  }
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
  if (ref.watch(isSaveLogProvider)) {
    // await removeLogCache(tr(AppL10n.logDelete));
  }
}

Future<void> deleteFile(Directory directory) async {
  try {
    await deleteToTrash(filePath: directory.path);
    // if (saveLog) await tempSaveDeleteLog(ref, directory.path);
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
