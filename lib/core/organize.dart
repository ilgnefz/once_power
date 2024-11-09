import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/notification_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/log.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/common/notification.dart';
import 'package:path/path.dart' as path;

import 'file.dart';

List<NotificationInfo> errorList = [];

String renameFile(String newPath) {
  int index = newPath.lastIndexOf('.');
  if (index == -1) index = newPath.length;
  int num = 0;
  while (
      File('${newPath.substring(0, index)} - $num${newPath.substring(index)}')
          .existsSync()) {
    num++;
  }
  return '${newPath.substring(0, index)} - $num${newPath.substring(index)}';
}

void moveFile(BuildContext context, WidgetRef ref, FileInfo file) {
  TextEditingController controller = ref.watch(targetControllerProvider);
  bool saveLog = ref.watch(saveLogProvider);
  String folderPath = controller.text;
  if (ref.watch(classifiedFileProvider) && !file.type.isFolder) {
    folderPath = createClassifyFolder(file, folderPath);
  }
  String newPath = path.join(folderPath, path.basename(file.filePath));
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
      createLog(
          controller.text, S.of(context).organizeLogs, file.filePath, newPath);
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
    } else {
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

void organizeFolder(BuildContext context, WidgetRef ref) async {
  List<FileInfo> realFiles = [];
  List<FileInfo> files = ref.watch(fileListProvider);
  int total = 0;
  for (var file in files) {
    if (!file.checked) continue;
    total++;
    if (file.type.isFolder) {
      if (!Directory(file.filePath).existsSync()) {
        errorList.add(
          NotificationInfo(
            file: file.filePath,
            message: S.of(context).notExist,
          ),
        );
        continue;
      }
      final list = getAllPath(file.filePath);
      for (var file in list) {
        FileInfo fileInfo = await generateFileInfo(ref, file);
        realFiles.add(fileInfo);
      }
      continue;
    }
    realFiles.add(file);
  }
  int count = 0;
  int startTime = DateTime.now().microsecondsSinceEpoch;
  for (var file in realFiles) {
    count++;
    if (!context.mounted) return;
    moveFile(context, ref, file);
    ref.read(countProvider.notifier).update(count);
    await Future.delayed(const Duration(microseconds: 1));
  }
  int endTime = DateTime.now().microsecondsSinceEpoch;
  double cost = (endTime - startTime) / 1000000;
  ref.read(costProvider.notifier).update(cost);
  if (!context.mounted) return;
  NotificationType type = errorList.isEmpty
      ? SuccessNotification(S.of(context).organizedSuccessfully,
          S.of(context).organizedSuccessfullyInfo(total))
      : ErrorNotification(S.of(context).organizingFailed,
          S.of(context).organizingFailedInfo, errorList);
  NotificationMessage.show(type);
}

void targetFolderCache(WidgetRef ref, String folder) async {
  if (ref.watch(saveConfigProvider)) {
    await StorageUtil.setString(AppKeys.targetFolder, folder);
    List<String> list = StorageUtil.getStringList(AppKeys.targetFolderList);
    if (list.contains(folder)) list.remove(folder);
    list.add(folder);
    await StorageUtil.setStringList(AppKeys.targetFolderList, list);
  }
}
