import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/model/notification.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/src/rust/api/simple.dart';
import 'package:once_power/util/notification.dart';

import 'list.dart';

List<InfoDetail> _errorList = [];

Future<void> organize(WidgetRef ref) async {
  _errorList.clear();
  String targetFolder = ref.read(folderControllerProvider).text;
  print('目标文件夹: $targetFolder');
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
