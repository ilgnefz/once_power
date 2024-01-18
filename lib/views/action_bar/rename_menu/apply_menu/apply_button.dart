import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/utils/utils.dart';
import 'package:path/path.dart' as path;

class ApplyButton extends ConsumerWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String applyChange = '应用更改';
    List<FileInfo> fileList = ref.watch(fileListProvider);

    void applyRename() {
      List<FileInfo> checkList = fileList.where((e) => e.checked).toList();
      int total = checkList.length;
      List<NotificationInfo> errorList = [];
      List<FileInfo> tempFileList = [];
      rename(ref, checkList, tempFileList, errorList);
      if (tempFileList.isNotEmpty) rename(ref, tempFileList, null, errorList);
      updateName(ref);
      updateExtension(ref);
      NotificationType type = errorList.isNotEmpty
          ? NotificationType.failure
          : NotificationType.success;
      List<NotificationInfo> list = errorList.isNotEmpty ? errorList : [];
      showNotification(type, list, total);
    }

    return ElevatedButton(
      onPressed: fileList.isEmpty ? null : applyRename,
      child: const Text(applyChange),
    );
  }
}

void rename(WidgetRef ref, List<FileInfo> fileList,
    List<FileInfo>? tempFileList, List<NotificationInfo> errorList) {
  for (FileInfo file in fileList) {
    bool sameName = file.name == file.newName;
    bool sameExtension = file.extension == file.newExtension;
    String extension = file.extension == 'dir' ? '' : '.${file.extension}';
    String newExtension =
        file.newExtension == 'dir' ? '' : '.${file.newExtension}';
    String oldPath = path.join(file.parent, '${file.name}$extension');
    String newPath = path.join(file.parent, '${file.newName}$newExtension');
    if (sameName && sameExtension) continue;
    if (File(newPath).existsSync()) {
      if (tempFileList != null) {
        tempFileList.add(file);
      } else {
        final oldFile = '${file.name}$extension';
        final newFile = '${file.newName}$newExtension';
        errorList.add(NotificationInfo(
          file: oldFile,
          message: ' 重命名为 $newFile 的文件已存在',
        ));
      }
      continue;
    }
    try {
      if (file.type == FileClassify.folder) {
        Directory(oldPath).renameSync(newPath);
      } else {
        File(oldPath).renameSync(newPath);
      }
      final fileInfo = ref.read(fileListProvider.notifier);
      fileInfo.updateOriginName(file.id, file.newName);
      fileInfo.updateFilePath(file.id, newPath);
      fileInfo.updateOriginExtension(file.id, file.newExtension);
      // count++;
    } catch (e) {
      Log.e(e.runtimeType.toString());
      String message = '';
      if (e.runtimeType == PathNotFoundException) {
        message = ' 在 ${file.parent} 中已不存在';
      } else {
        message = ' 因为 $e 重命名失败';
      }
      errorList.add(NotificationInfo(
        file: '${file.name}$extension',
        message: message,
      ));
    }
  }
}

void showNotification(
    NotificationType type, List<NotificationInfo> list, int total) {
  if (type == NotificationType.success) {
    NotificationMessage.show('重命名成功', '选中的 $total 个已全部重命名成功', [], type);
  } else {
    String message = '选中 $total 个中 ${list.length} 个重命名失败';
    NotificationMessage.show('重命名失败', message, list, type);
  }
}
