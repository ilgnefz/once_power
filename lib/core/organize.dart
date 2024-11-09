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
import 'package:once_power/utils/utils.dart';
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

Future<void> easyMoveFiles(String newPath, String oldPath, bool saveLog) async {
  bool isFile = await FileSystemEntity.isFile(oldPath);
  try {
    if (isFile) {
      File(oldPath).renameSync(newPath);
    } else {
      Directory(oldPath).renameSync(newPath);
    }
    if (saveLog) {
      createLog('', S.current.organizeLogs, oldPath, newPath);
    }
  } catch (e) {
    errorList.add(NotificationInfo(
      file: oldPath,
      message: '${S.current.moveFailed}: $e',
    ));
    Log.e(e.toString());
  }
}

void moveFile(BuildContext context, WidgetRef ref, FileInfo file) {
  TextEditingController controller = ref.watch(targetControllerProvider);
  bool saveLog = ref.watch(saveLogProvider);

  String folderPath = controller.text;
  if (folderPath == '') {
    noTargetFolder(ref, file, saveLog);
  } else {
    haveTargetFolder(ref, folderPath, file, saveLog);
  }
}

void noTargetFolder(WidgetRef ref, FileInfo file, bool saveLog) async {
  bool useTopFolder = ref.watch(useTopFolderProvider);
  if (useTopFolder) {
    String folderPath = getTopPath(file.filePath);
    if (folderPath == file.parent) return;
    String newPath = path.join(folderPath, path.basename(file.filePath));
    if (File(newPath).existsSync()) newPath = renameFile(newPath);
    await easyMoveFiles(newPath, file.filePath, saveLog);
    final fileInfo = ref.read(fileListProvider.notifier);
    fileInfo.updateFilePath(file.id, newPath);
    fileInfo.updateFileParent(file.id, folderPath);
  }
  // else {
  //   List<(String, bool)> folders = getParentPath(file.filePath);
  //   print(folders);
  //   for (var folder in folders.reversed) {
  //     if (folder.$2) continue;
  //     if (folder != folders.first) {}
  //     String newPath = path.join(folder.$1, path.basename(file.filePath));
  //     if (File(newPath).existsSync()) newPath = renameFile(newPath);
  //   }
  // }
}

void haveTargetFolder(
    WidgetRef ref, String folderPath, FileInfo file, bool saveLog) {
  if (ref.watch(classifiedFileProvider) && !file.type.isFolder) {
    folderPath = createClassifyFolder(file, folderPath);
  }
  String newPath = path.join(folderPath, path.basename(file.filePath));
  if (!File(file.filePath).existsSync()) {
    errorList.add(
      NotificationInfo(file: file.filePath, message: S.current.notExist),
    );
    return;
  }

  if (folderPath == file.parent) return;
  if (File(newPath).existsSync()) newPath = renameFile(newPath);
  if (saveLog) {
    createLog(folderPath, S.current.organizeLogs, file.filePath, newPath);
  }
  bool sameDisk = file.filePath[0] == newPath[0];
  if (sameDisk) {
    try {
      File(file.filePath).renameSync(newPath);
    } catch (e) {
      errorList.add(NotificationInfo(
        file: file.filePath,
        message: '${S.current.moveFailed}: $e',
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
        message: '${S.current.moveError}: $e',
      ));
      Log.e(e.toString());
      return;
    }
  }

  final fileInfo = ref.read(fileListProvider.notifier);
  fileInfo.updateFilePath(file.id, newPath);
  fileInfo.updateFileParent(file.id, folderPath);
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
      for (var child in list) {
        FileInfo childFile = await generateFileInfo(ref, child);
        realFiles.add(childFile);
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

Future<void> targetFolderCache(WidgetRef ref, String folder) async {
  if (ref.watch(saveConfigProvider)) {
    await StorageUtil.setString(AppKeys.targetFolder, folder);
    List<String> list = StorageUtil.getStringList(AppKeys.targetFolderList);
    if (list.contains(folder)) list.remove(folder);
    list.add(folder);
    await StorageUtil.setStringList(AppKeys.targetFolderList, list);
  }
}

void saveLogContent(String filePath) {
  final fileName = formatDateTime(DateTime.now()).substring(0, 8);
  final appDir = Platform.resolvedExecutable;
  final log =
      File(path.join(appDir, 'logs', '${S.current.deleteLog}-$fileName.log'));
  String contents = S.current.deleteInfo(filePath);
  log.writeAsStringSync('$contents\n', mode: FileMode.append);
}
