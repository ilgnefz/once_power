import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/utils.dart';
import 'package:path/path.dart' as path;

class ArrangeButton extends ConsumerWidget {
  const ArrangeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String arrangeFolder = '整理文件夹';
    List<FileInfo> realFiles = [];
    List<NotificationInfo> errorList = [];

    String renameFile(String newPath) {
      int index = newPath.lastIndexOf('.');
      if (index == -1) index = newPath.length;
      int num = 0;
      while (File(
              '${newPath.substring(0, index)} - $num${newPath.substring(index)}')
          .existsSync()) {
        num++;
      }
      return '${newPath.substring(0, index)} - $num${newPath.substring(index)}';
    }

    void moveFile(FileInfo file) {
      TextEditingController controller = ref.watch(targetControllerProvider);
      bool saveLog = ref.watch(saveLogProvider);
      String newPath = path.join(controller.text, path.basename(file.filePath));
      if (!File(file.filePath).existsSync()) {
        return errorList
            .add(NotificationInfo(file: file.filePath, message: '不存在'));
      }
      if (newPath != file.filePath) {
        if (File(newPath).existsSync()) newPath = renameFile(newPath);
        if (saveLog) {
          final fileName = formatDateTime(DateTime.now()).substring(0, 14);
          final log = File(path.join(controller.text, '整理日志$fileName.log'));
          String contents = '【${file.filePath}】 ---> 【$newPath】';
          log.writeAsStringSync('$contents\n', mode: FileMode.append);
        }
        try {
          File(file.filePath).renameSync(newPath);
        } catch (e) {
          errorList.add(NotificationInfo(
            file: file.filePath,
            message: '移动失败：$e',
          ));
        }
      }
    }

    void showNotification() {
      if (errorList.isEmpty) {
        NotificationMessage.show('整理成功', '已成功移动所有文件', [], MessageType.success);
      } else {
        NotificationMessage.show(
            '整理失败', '以下几个移动失败！', errorList, MessageType.failure);
      }
    }

    Future<void> realFile(WidgetRef ref, String filePath) async {
      bool isFile = FileSystemEntity.isFileSync(filePath);
      FileInfo fileInfo = await generateFileInfo(ref, filePath, isFile);
      realFiles.add(fileInfo);
    }

    void organizeFolder() async {
      List<FileInfo> files = ref.watch(fileListProvider);
      for (var file in files) {
        if (file.type == FileClassify.folder) {
          if (!Directory(file.filePath).existsSync()) {
            errorList
                .add(NotificationInfo(file: file.filePath, message: '不存在'));
            continue;
          }
          final list = getAllFile(file.filePath);
          for (var file in list) {
            await realFile(ref, file);
          }
          continue;
        }
        realFiles.add(file);
      }
      for (var file in realFiles) {
        moveFile(file);
      }
      showNotification();
    }

    return ElevatedButton(
      onPressed: ref.watch(fileListProvider).isEmpty ? null : organizeFolder,
      child: const Text(arrangeFolder),
    );
  }
}
