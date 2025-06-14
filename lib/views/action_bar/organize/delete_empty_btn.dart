import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/cores/oplog.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/src/rust/api/simple.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/common/easy_elevated_btn.dart';

class DeleteEmptyBtn extends ConsumerWidget {
  const DeleteEmptyBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<InfoDetail> errorList = [];
    bool saveLog = ref.watch(isSaveLogProvider);

    Future<void> delete(Directory directory) async {
      try {
        await deleteToTrash(filePath: directory.path);
        // if (saveLog) saveLogContent(directory.path);
        if (saveLog) await tempSaveDeleteLog(ref, directory.path);
      } catch (e) {
        errorList.add(InfoDetail(
          file: directory.path,
          message: '${S.current.deleteFailed}: $e',
        ));
      }
    }

    Future<void> deleteFolders(String folderPath) async {
      var directory = Directory(folderPath);
      if (await directory.exists()) {
        final entities = await directory.list().toList();
        // 检查初始空目录
        if (entities.isEmpty) return await delete(directory);

        // 异步递归处理子目录
        await for (final entity in directory.list(recursive: false)) {
          if (await FileSystemEntity.isDirectory(entity.path)) {
            await deleteFolders(entity.path);
          }
        }

        // 处理完子项后重新检查目录是否为空
        final remainingEntities = await directory.list().toList();
        if (remainingEntities.isEmpty) await delete(directory);
      }
    }

    Future<void> deleteEmptyFolder() async {
      List<FileInfo> files = ref.read(fileListProvider);
      for (var file in files) {
        if (!file.checked) continue;
        if (!file.type.isFolder) continue;
        deleteFolders(file.filePath);
      }
      showDeleteNotification(errorList);
      if (ref.watch(isSaveLogProvider)) {
        await removeLogCache(S.current.deleteLog);
      }
    }

    return EasyElevatedBtn(
      onPressed: disabledBtn(ref) ? null : deleteEmptyFolder,
      label: S.of(context).deleteEmptyFolder,
    );
  }
}
