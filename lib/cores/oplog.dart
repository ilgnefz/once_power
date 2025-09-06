import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/utils/storage.dart';
import 'package:path/path.dart' as path;

Future<void> createLog(
  String filePath,
  String fileName,
  List<String> logs,
) async {
  final String time = formatDateTime(DateTime.now()).substring(0, 14);
  String folder = filePath == ''
      ? path.join(path.dirname(Platform.resolvedExecutable), 'logs')
      : filePath;
  Directory dir = Directory(folder);
  if (!dir.existsSync()) await dir.create();
  final File logFile = File(path.join(folder, '$fileName-$time.oplog'));
  String content = logs.join('\n');
  debugPrint('已成功创建日志文件:${logFile.path}');
  logFile.writeAsStringSync(content, mode: FileMode.write);
}

Future<void> tempSaveLog(WidgetRef ref, String oldPath, String newPath) async {
  String content = '${DateTime.now()}: 【$oldPath】===>【$newPath】';
  await cacheLog(content);
}

Future<void> tempSaveDeleteLog(WidgetRef ref, String filePath) async {
  String content = tr(AppL10n.successDeleteFile, namedArgs: {'file': filePath});
  await cacheLog(content);
}

Future<void> cacheLog(String content) async {
  List<String> logs = StorageUtil.getStringList(AppKeys.operateLogList);
  logs.add(content);
  await StorageUtil.setStringList(AppKeys.operateLogList, logs);
}

Future<void> removeLogCache(String title) async {
  List<String> logs = StorageUtil.getStringList(AppKeys.operateLogList);
  await createLog('', title, logs);
  StorageUtil.remove(AppKeys.operateLogList);
}
