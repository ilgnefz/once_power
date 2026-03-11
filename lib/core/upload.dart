import 'dart:io';

import 'package:charset/charset.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/util/notification.dart';
import 'package:path/path.dart' as path;

import 'file.dart';
import 'update/update.dart';

void dropFile(DropDoneDetails details, WidgetRef ref) async {
  List<XFile> paths = details.files;
  if (paths.isNotEmpty) {
    final List<String> files = paths.map((e) => e.path).toList();
    await formatPath(ref, files);
    updateName(ref);
  }
}

Future<void> uploadFile(WidgetRef ref) async {
  final List<XFile> files = await openFiles();
  if (files.isNotEmpty) {
    await formatXFile(ref, files);
    updateName(ref);
  }
}

Future<void> uploadFolder(WidgetRef ref) async {
  final List<String?> folders = await getDirectoryPaths();
  final List<String> validFolders = folders
      .whereType<String>()
      .where((f) => f.isNotEmpty)
      .toList();
  if (validFolders.isNotEmpty) {
    await formatFolder(ref, validFolders);
    updateName(ref);
  }
}

Future<UploadMarkInfo?> uploadTextFile(String filePath) async {
  String fileName = path.basename(filePath);
  String content = '';
  final File file = File(filePath);
  try {
    content = await file.readAsString();
  } catch (e) {
    try {
      final bytes = await file.readAsBytes();
      content = gbk.decode(bytes);
    } catch (gbError) {
      showTxtDecodeNotification(gbError.toString());
      return null;
    }
  }
  return UploadMarkInfo(name: fileName, content: content);
}
