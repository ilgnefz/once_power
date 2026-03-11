import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/notification.dart';
import 'package:path/path.dart' as path;

class LogServer {
  static final List<String> _logs = [];

  LogServer._internal();

  static final LogServer _instance = LogServer._internal();

  factory LogServer() => _instance;

  static void init() => _logs.clear();

  static void add(String log) => _logs.add(log);

  static Future<void> create() async {
    String time = formatDateTime(DateTime.now()).substring(0, 14);
    String appPath = Platform.resolvedExecutable;
    String folder = path.join(path.dirname(appPath), 'logs');
    Directory dir = Directory(folder);
    if (!await dir.exists()) await dir.create();
    File file = File(path.join(folder, 'log_$time.log'));
    String content = _logs.join('\n');
    try {
      await file.writeAsString(content);
      debugPrint('已成功创建日志文件: ${file.path}');
    } catch (e) {
      // TODO: 发送通知
      showCreateLogError(e.toString());
      debugPrint('创建日志文件失败: $e');
    }
  }
}

String logInfo(String oldPath, String newPath) => '$oldPath <=====> $newPath';
