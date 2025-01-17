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

Future<void> moveFile(WidgetRef ref, FileInfo file) async {
  TextEditingController controller = ref.watch(targetControllerProvider);
  String folderPath = controller.text;
  if (folderPath == '') {
    await noTargetFolder(ref, file);
  } else {
    haveTargetFolder(ref, folderPath, file);
  }
}

Future<void> easyMoveFile(WidgetRef ref, String newPath, String oldPath) async {
  bool isFile = await FileSystemEntity.isFile(oldPath);
  bool saveLog = ref.watch(saveLogProvider);
  try {
    if (isFile) {
      await File(oldPath).rename(newPath);
    } else {
      await Directory(oldPath).rename(newPath);
    }
    if (saveLog) tempSaveLog(ref, oldPath, newPath);
  } catch (e) {
    String message = '${S.current.moveFailed}: $e';
    errorList.add(NotificationInfo(file: oldPath, message: message));
    if (saveLog) tempSaveLog(ref, oldPath, oldPath);
    Log.e(e.toString());
  }
}

Future<void> noTargetFolder(WidgetRef ref, FileInfo file) async {
  bool useTopFolder = ref.watch(useTopFolderProvider);
  if (useTopFolder) {
    String folderPath = getTopPath(file.filePath);
    if (folderPath == file.parent) return;
    String newPath = path.join(folderPath, path.basename(file.filePath));
    if (File(newPath).existsSync()) newPath = renameFile(newPath);
    await easyMoveFile(ref, newPath, file.filePath);
    final FileList fileInfo = ref.read(fileListProvider.notifier);
    fileInfo.updateFilePath(file.id, newPath);
    fileInfo.updateFileParent(file.id, folderPath);
  }
}

void haveTargetFolder(WidgetRef ref, String folderPath, FileInfo file) {
  bool saveLog = ref.watch(saveLogProvider);
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
  bool sameDisk = file.filePath[0] == newPath[0];
  try {
    if (sameDisk) {
      File(file.filePath).renameSync(newPath);
    } else {
      File(file.filePath).copySync(newPath);
      File(file.filePath).deleteSync();
    }
    if (saveLog) tempSaveLog(ref, file.filePath, newPath);
  } catch (e) {
    String message = '${S.current.moveFailed}: $e';
    if (sameDisk) message = '${S.current.moveError}: $e';
    errorList.add(NotificationInfo(file: file.filePath, message: message));
    if (saveLog) tempSaveLog(ref, file.filePath, file.filePath);
    Log.e(e.toString());
    return;
  }

  final FileList fileInfo = ref.read(fileListProvider.notifier);
  fileInfo.updateFilePath(file.id, newPath);
  fileInfo.updateFileParent(file.id, folderPath);
}

void organizeFolder(BuildContext context, WidgetRef ref) async {
  List<FileInfo> realFiles = [];
  List<FileInfo> files = ref.watch(fileListProvider);
  int total = 0;
  for (FileInfo file in files) {
    if (!file.checked) continue;
    total++;
    if (file.type.isFolder) {
      if (!Directory(file.filePath).existsSync()) {
        String message = S.of(context).notExist;
        errorList.add(NotificationInfo(file: file.filePath, message: message));
        continue;
      }
      final List<String> list = getAllPath(file.filePath);
      for (String child in list) {
        bool isFile = await FileSystemEntity.isFile(child);
        FileInfo childFile = await generateFileInfo(ref, child, isFile);
        realFiles.add(childFile);
      }
      continue;
    }
    realFiles.add(file);
  }
  int count = 0;
  int startTime = DateTime.now().microsecondsSinceEpoch;
  for (FileInfo file in realFiles) {
    count++;
    if (!context.mounted) return;
    await moveFile(ref, file);
    ref.read(countProvider.notifier).update(count);
    await Future.delayed(const Duration(microseconds: 1));
  }
  int endTime = DateTime.now().microsecondsSinceEpoch;
  double cost = (endTime - startTime) / 1000000;
  ref.read(costProvider.notifier).update(cost);
  if (ref.watch(saveLogProvider)) {
    List<String> logs = ref.watch(operateLogListProvider);
    // print(logs);
    String folder = ref.watch(targetControllerProvider).text;
    await createLog(folder, S.current.organizeLogs, logs);
    ref.read(operateLogListProvider.notifier).clear();
  }
  NotificationType type = errorList.isEmpty
      ? SuccessNotification(S.current.organizedSuccessfully,
          S.current.organizedSuccessfullyInfo(total))
      : ErrorNotification(S.current.organizingFailed,
          S.current.organizingFailedInfo, errorList);
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

void saveLogContent1(String filePath) {
  final String fileName = formatDateTime(DateTime.now()).substring(0, 14);
  final String appDir = Platform.resolvedExecutable;
  String fullFileName = '${S.current.deleteLog}-$fileName.log';
  final File logFile = File(path.join(appDir, 'logs', fullFileName));
  String contents = S.current.deleteInfo(filePath);
  logFile.writeAsStringSync('$contents\n', mode: FileMode.write);
}
