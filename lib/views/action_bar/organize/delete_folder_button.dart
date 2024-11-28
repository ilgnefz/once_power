import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/file.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/notification_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/common/notification.dart';

class DeleteFolderButton extends ConsumerWidget {
  const DeleteFolderButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NotificationInfo> errorList = [];
    bool saveLog = ref.watch(saveLogProvider);

    void delete(Directory directory) {
      try {
        directory.deleteSync();
        // if (saveLog) saveLogContent(directory.path);
        if (saveLog) tempSaveDeleteLog(ref, directory.path);
      } catch (e) {
        errorList.add(NotificationInfo(
          file: directory.path,
          message: '${S.of(context).deleteFailed}: $e',
        ));
      }
    }

    void deleteFolders(String folderPath) {
      var directory = Directory(folderPath);
      if (directory.existsSync()) {
        bool isEmpty = directory.listSync().isEmpty;
        if (isEmpty) return delete(directory);
        directory.listSync().forEach((file) {
          if (FileSystemEntity.isDirectorySync(file.path)) {
            deleteFolders(file.path);
          }
        });
        if (directory.listSync().isEmpty) delete(directory);
      }
    }

    Future<void> deleteEmptyFolder() async {
      List<FileInfo> files = ref.read(fileListProvider);
      for (var file in files) {
        if (!file.checked) continue;
        if (file.type != FileClassify.folder) continue;
        deleteFolders(file.filePath);
      }
      if (ref.watch(saveLogProvider)) {
        List<String> logs = ref.watch(operateLogListProvider);
        await createLog('', S.current.deleteLog, logs);
        ref.read(operateLogListProvider.notifier).clear();
      }
      NotificationType type = errorList.isEmpty
          ? SuccessNotification(
              S.current.deleteSuccessful, S.current.successEmptyInfo)
          : ErrorNotification(
              S.current.deleteFailed, S.current.failureEmptyInfo, errorList);
      NotificationMessage.show(type);
    }

    return ElevatedButton(
      onPressed: ref.watch(fileListProvider).isEmpty ? null : deleteEmptyFolder,
      child:
          Text(S.of(context).deleteEmptyFolder, style: TextStyle(fontSize: 14)),
    );
  }
}
