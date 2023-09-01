import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/notification_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/utils/notification.dart';
import 'package:path/path.dart' as path;

class DeleteFolderButton extends ConsumerWidget {
  const DeleteFolderButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NotificationInfo> errorList = [];
    bool saveLog = ref.watch(saveLogProvider);
    TextEditingController controller = ref.watch(targetControllerProvider);

    void delete(Directory directory) {
      try {
        directory.deleteSync();
        if (saveLog) {
          final fileName = formatDateTime(DateTime.now()).substring(0, 14);
          final log = File(path.join(controller.text, '日志$fileName.log'));
          String contents = '【${directory.path}】 已被删除';
          log.writeAsStringSync('$contents\n', mode: FileMode.append);
        }
      } catch (e) {
        errorList.add(NotificationInfo(
          file: directory.path,
          message: '删除失败，$e',
        ));
      }
    }

    void deleteFolders(String folderPath) {
      var directory = Directory(folderPath);
      if (directory.existsSync()) {
        var isEmpty = directory.listSync().isEmpty;
        if (isEmpty) return delete(directory);
        directory.listSync().forEach((file) {
          if (FileSystemEntity.isDirectorySync(file.path)) {
            deleteFolders(file.path);
          }
        });
        if (directory.listSync().isEmpty) delete(directory);
      }
    }

    void deleteEmptyFolder() {
      List<FileInfo> files = ref.read(fileListProvider);
      for (var file in files) {
        if (file.type != FileClassify.folder) return;
        deleteFolders(file.filePath);
      }
      if (errorList.isEmpty) {
        NotificationMessage.show(
          '删除成功',
          '已成功删除所有空文件夹',
          [],
          MessageType.success,
        );
      } else {
        NotificationMessage.show(
          '删除失败',
          '删除空文件夹失败！',
          errorList,
          MessageType.failure,
        );
      }
    }

    return ElevatedButton(
      onPressed: ref.watch(fileListProvider).isEmpty ? null : deleteEmptyFolder,
      child: const Text('删除空文件夹'),
    );
  }
}
