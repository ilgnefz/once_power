import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/notification_info.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/file.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/utils/notification.dart';
import 'package:path/path.dart' as path;

class OrganizeButton extends ConsumerWidget {
  const OrganizeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      if (newPath != file.filePath) {
        if (File(newPath).existsSync()) newPath = renameFile(newPath);
        if (saveLog) {
          final fileName = formatDateTime(DateTime.now()).substring(0, 14);
          final log = File(path.join(controller.text, '日志$fileName.log'));
          String contents = '【${file.filePath}】 ---> 【$newPath】';
          log.writeAsStringSync('$contents\n', mode: FileMode.append);
        }
        try {
          File(file.filePath).renameSync(newPath);
        } catch (e) {
          errorList.add(NotificationInfo(
            file: file.filePath,
            message: '移动失败，$e',
          ));
        }
      }
    }

    Future<void> realFile(WidgetRef ref, String filePath) async {
      bool isFile = FileSystemEntity.isFileSync(filePath);
      String id = nanoid(10);
      String name = path.basename(filePath);
      String extension = 'dir';
      DateTime? exifDate;
      DateTime createDate = File(filePath).statSync().changed;
      DateTime modifyDate = File(filePath).statSync().modified;
      if (isFile) {
        extension = path.extension(filePath);
        if (extension != '') {
          name = name.split(extension).first;
          extension = extension.substring(1);
        }
        if (image.contains(extension)) {
          exifDate = await getExifDate(filePath);
        }
      }
      FileClassify type = ref.read(getFileClassifyProvider(extension));
      FileInfo renameFile = FileInfo(
        id: id,
        name: name,
        newName: name,
        parent: path.dirname(filePath),
        filePath: filePath,
        extension: extension,
        newExtension: extension,
        createDate: createDate,
        modifyDate: modifyDate,
        exifDate: exifDate,
        type: type,
        checked: true,
      );
      realFiles.add(renameFile);
    }

    void organizeFolder() async {
      List<FileInfo> files = ref.watch(fileListProvider);
      for (var file in files) {
        if (file.type == FileClassify.folder) {
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
      if (errorList.isEmpty) {
        NotificationMessage.show(
          '整理成功',
          '已成功移动所有文件',
          [],
          MessageType.success,
        );
      } else {
        NotificationMessage.show(
          '整理失败',
          '以下几个文件移动失败！',
          errorList,
          MessageType.failure,
        );
      }
    }

    return ElevatedButton(
      onPressed: ref.watch(fileListProvider).isEmpty ? null : organizeFolder,
      child: const Text('整理文件夹'),
    );
  }
}
