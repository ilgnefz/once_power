import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/model/rename_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/utils/utils.dart';
import 'package:path/path.dart' as path;

class ApplyButton extends ConsumerWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String applyChange = '应用更改';

    List<RenameFile> fileList = ref.watch(fileListProvider);

    applyRename() {
      int total = fileList.where((e) => e.checked).toList().length;
      int count = 0;
      List<RenameInfo> errorList = [];
      List<RenameInfo> warningList = [];
      for (RenameFile file in fileList) {
        bool sameName = file.name == file.newName;
        bool sameExtension = file.extension == file.newExtension;
        if (file.checked) {
          String extension =
              file.extension == 'dir' ? '' : '.${file.extension}';
          String newExtension =
              file.newExtension == 'dir' ? '' : '.${file.newExtension}';
          String oldPath = path.join(file.parent, '${file.name}$extension');
          String newPath =
              path.join(file.parent, '${file.newName}$newExtension');
          if (sameName && sameExtension) {
            warningList.add(RenameInfo(
              file: '${file.name}$extension',
              message: ' 没有更改名称' * 5,
            ));
            continue;
          }
          if (File(newPath).existsSync()) {
            final oldFile = '${file.name}$extension';
            final newFile = '${file.newName}$newExtension';
            warningList.add(RenameInfo(
              file: oldFile,
              message: ' 重命名为 $newFile 的文件已存在',
            ));
            continue;
          }
          try {
            if (file.type == FileClassify.folder) {
              Directory(newPath).renameSync(newPath);
            } else {
              File(oldPath).renameSync(newPath);
            }
            final fileInfo = ref.read(fileListProvider.notifier);
            fileInfo.updateOriginName(file.id, file.newName);
            fileInfo.updateOriginExtension(file.id, file.newExtension);
            count++;
          } catch (e) {
            errorList.add(RenameInfo(
              file: '${file.name}$extension',
              message: ' 因为 $e 重命名失败',
            ));
          }
        }
      }
      updateName(ref);
      updateExtension(ref);
      MessageType type = errorList.isNotEmpty
          ? MessageType.failure
          : warningList.isNotEmpty
              ? MessageType.warning
              : MessageType.success;
      List<RenameInfo> list = type == MessageType.failure
          ? errorList
          : type == MessageType.warning
              ? warningList
              : [];
      showToast(type, list, total, count);
    }

    return ElevatedButton(
      onPressed: fileList.isEmpty ? null : applyRename,
      child: const Text(applyChange),
    );
  }
}

void showToast(MessageType type, List<RenameInfo> list, int total, int count) {
  if (type == MessageType.success) {
    NotificationMessage.show('重命名成功', '选中的 $total 个已全部重命名成功', [], type);
  }
  if (type == MessageType.failure) {
    String message = list.isEmpty
        ? '请先更改文件名称后再继续操作'
        : '选中 $total 个中 ${total - count} 个重命名失败';
    List<RenameInfo> infoList = list.isEmpty ? [] : list;
    NotificationMessage.show('重命名失败', message, infoList, type);
  }
  if (type == MessageType.warning) {
    NotificationMessage.show(
      '重命名警告',
      '选中 $total 个中 $count 个重命名成功，${total - count} 个重命名失败',
      list,
      type,
    );
  }
}
