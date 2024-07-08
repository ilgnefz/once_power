import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/utils.dart';
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

      if (!File(file.filePath).existsSync()) {
        errorList.add(
          NotificationInfo(
            file: file.filePath,
            message: S.of(context).notExist,
          ),
        );
        return;
      }

      if (newPath != file.filePath) {
        if (File(newPath).existsSync()) newPath = renameFile(newPath);
        if (saveLog) {
          final fileName = formatDateTime(DateTime.now()).substring(0, 14);
          final log = File(path.join(
              controller.text, '${S.of(context).organizeLogs}-$fileName.log'));
          String contents =
              '${DateTime.now()}:【${file.filePath}】 ————→ 【$newPath】';
          log.writeAsStringSync('$contents\n', mode: FileMode.append);
        }

        bool sameDisc = file.filePath[0] == newPath[0];
        if (sameDisc) {
          try {
            File(file.filePath).renameSync(newPath);
          } catch (e) {
            errorList.add(NotificationInfo(
              file: file.filePath,
              message: '${S.of(context).moveFailed}: $e',
            ));
            Log.e(e.toString());
          }
        }

        if (!sameDisc) {
          try {
            File(file.filePath).copySync(newPath);
            File(file.filePath).deleteSync();
          } catch (e) {
            errorList.add(NotificationInfo(
              file: file.filePath,
              message: '${S.of(context).moveError}: $e',
            ));
            Log.e(e.toString());
            return;
          }
        }

        final fileInfo = ref.read(fileListProvider.notifier);
        fileInfo.updateFilePath(file.id, newPath);
        fileInfo.updateFileParent(file.id, controller.text);
      }
    }

    Future<void> realFile(WidgetRef ref, String filePath) async {
      FileInfo fileInfo = await generateFileInfo(ref, filePath);
      realFiles.add(fileInfo);
    }

    void organizeFolder() async {
      List<FileInfo> files = ref.watch(fileListProvider);
      for (var file in files) {
        if (file.type == FileClassify.folder) {
          if (!Directory(file.filePath).existsSync()) {
            errorList.add(
              NotificationInfo(
                file: file.filePath,
                message: S.of(context).notExist,
              ),
            );
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
      NotificationType type = errorList.isEmpty
          ? SuccessNotification(S.of(context).organizedSuccessfully,
              S.of(context).organizedSuccessfullyInfo)
          : ErrorNotification(S.of(context).organizingFailed,
              S.of(context).organizingFailedInfo, errorList);
      NotificationMessage.show(type);
    }

    return ElevatedButton(
      onPressed:
          ref.watch(fileListProvider).isEmpty || !ref.watch(targetClearProvider)
              ? null
              : organizeFolder,
      child: Text(S.of(context).organizeFolder),
    );
  }
}
