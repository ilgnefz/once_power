import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/cores/oplog.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/src/rust/api/simple.dart';
import 'package:once_power/widgets/base/easy_elevated_btn.dart';

class DeleteEmptyBtn extends ConsumerWidget {
  const DeleteEmptyBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<InfoDetail> errorList = [];
    bool saveLog = ref.watch(isSaveLogProvider);

    Future<void> delete(Directory directory) async {
      try {
        await deleteToTrash(filePath: directory.path);
        if (saveLog) await tempSaveDeleteLog(ref, directory.path);
      } catch (e) {
        errorList.add(
          InfoDetail(
            file: directory.path,
            message: '${tr(AppL10n.errDelete)}: $e',
          ),
        );
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
      for (FileInfo file in files) {
        if (!file.checked) continue;
        if (!file.type.isFolder) continue;
        deleteFolders(file.path);
      }
      showDeleteNotification(errorList);
      if (ref.watch(isSaveLogProvider)) {
        await removeLogCache(tr(AppL10n.logDelete));
      }
    }

    return EasyElevatedBtn(
      label: tr(AppL10n.organizeEmpty),
      onPressed: deleteEmptyFolder,
    );
  }
}
