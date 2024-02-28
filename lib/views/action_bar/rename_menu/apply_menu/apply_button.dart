import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/utils/utils.dart';
import 'package:path/path.dart' as path;

FileInfo errFile = FileInfo(
  id: '',
  name: '',
  newName: '',
  parent: '',
  filePath: '',
  extension: '',
  newExtension: '',
  createDate: DateTime.now(),
  modifyDate: DateTime.now(),
  type: FileClassify.other,
  checked: false,
);

class ApplyButton extends ConsumerWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String applyChange = '应用更改';
    List<FileInfo> fileList = ref.watch(sortListProvider);
    List<FileInfo> checkList = fileList.where((e) => e.checked).toList();
    List<NotificationInfo> errorList = [];
    int total = checkList.length;

    void applyRename() async {
      if (total > 1) {
        FileInfo first = checkList.first;
        String firstExtension =
            first.newExtension == 'dir' ? '' : '.${first.newExtension}';
        String firstPath =
            path.join(first.parent, '${first.newName}$firstExtension');

        FileInfo f = checkList.firstWhere((f) {
          String fExtension = f.extension == 'dir' ? '' : '.${f.extension}';
          String fPath = path.join(f.parent, '${f.name}$fExtension');
          return fPath == firstPath;
        }, orElse: () => errFile);

        List<FileInfo> list =
            f == errFile ? checkList : checkList.reversed.toList();
        await rename(ref, list, errorList);
      } else {
        await rename(ref, checkList, errorList);
      }
      updateName(ref);
      updateExtension(ref);
      NotificationType type = errorList.isNotEmpty
          ? NotificationType.failure
          : NotificationType.success;
      List<NotificationInfo> infoList = errorList.isNotEmpty ? errorList : [];
      showNotification(type, infoList, total);
    }

    return ElevatedButton(
      onPressed: fileList.isEmpty ? null : applyRename,
      child: const Text(applyChange),
    );
  }
}

Future<void> rename(WidgetRef ref, List<FileInfo> list,
    List<NotificationInfo> errorList) async {
  ref.read(totalProvider.notifier).update(list.length);
  int count = 0;
  bool delay = list.length > 150;
  int startTime = DateTime.now().microsecondsSinceEpoch;
  for (FileInfo f in list) {
    bool sameName = f.name == f.newName;
    bool sameExtension = f.extension == f.newExtension;
    if (sameName && sameExtension) continue;
    String extension = f.extension == 'dir' ? '' : '.${f.extension}';
    String newExtension = f.newExtension == 'dir' ? '' : '.${f.newExtension}';
    String oldPath = path.join(f.parent, '${f.name}$extension');
    String newPath = path.join(f.parent, '${f.newName}$newExtension');
    if (File(newPath).existsSync()) {
      final oldFile = '${f.name}$extension';
      final newFile = '${f.newName}$newExtension';
      errorList.add(NotificationInfo(
        file: oldFile,
        message: ' 重命名为 $newFile 的文件已存在',
      ));
      continue;
    }
    try {
      if (f.type == FileClassify.folder) {
        Directory(oldPath).renameSync(newPath);
      } else {
        File(oldPath).renameSync(newPath);
      }
      final fileInfo = ref.read(fileListProvider.notifier);
      fileInfo.updateOriginName(f.id, f.newName);
      fileInfo.updateFilePath(f.id, newPath);
      fileInfo.updateOriginExtension(f.id, f.newExtension);
    } catch (e) {
      Log.e(e.runtimeType.toString());
      String message = '';
      if (e.runtimeType == PathNotFoundException) {
        message = ' 在 ${f.parent} 中已不存在';
      } else {
        message = ' 因为 $e 重命名失败';
      }
      errorList.add(NotificationInfo(
        file: '${f.name}$extension',
        message: message,
      ));
    }
    count++;
    ref.read(countProvider.notifier).update(count);
    if (delay) await Future.delayed(const Duration(microseconds: 1));
  }
  int endTime = DateTime.now().microsecondsSinceEpoch;
  double cost = (endTime - startTime) / 1000000;
  ref.read(costProvider.notifier).update(cost);
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
