import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constant/key.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/service/storage.dart';

import 'file.dart';

// class _DropValue(final String name, final String? path);
class _Condition(final bool addSubfolder, final bool addSelf);

void clearList(WidgetRef ref) {
  bool isAppend = ref.read(isAppendProvider);
  if (!isAppend) ref.read(fileListProvider.notifier).clear();
}

void pickerFiles(WidgetRef ref) {}

void pickerFolders(WidgetRef ref) {}

Future<void> dropFiles(DropDetails details, WidgetRef ref) async {
  List<DropItem> items = details.items;
  if (items.isEmpty) return;
  clearList(ref);
  bool isAddFolder = ref.read(isAddFolderProvider);
  bool isAddSubfolder = ref.read(isAddSubfolderProvider);
  bool isAddSelf = StorageService.getBoolDefault(AppKeys.addSelf);
  List<String> paths = [];
  for (DropItem item in items) {
    if (item is DropDirectoryItem) {
      String? folderPath = item.localPath;
      if (folderPath == null) continue;
      if (isAddFolder) {
        _Condition condition = _Condition(isAddSubfolder, isAddSelf);
        paths.addAll(await _handleFolder(folderPath, condition));
      } else {
        paths.addAll(await _getChildren(folderPath, false));
      }
    } else if (item is DropFileItem) {
      String? filePath = item.localPath;
      if (filePath == null) continue;
      paths.add(filePath);
    }
  }
  getFileInfo(ref, paths);
}

Future<List<String>> _handleFolder(String? folder, _Condition condition) async {
  if (folder == null) return [];
  if (!condition.addSubfolder) return [folder];
  List<String> paths = [];
  if (condition.addSelf) paths.add(folder);
  paths.addAll(await _getChildren(folder, true));
  return paths;
}

Future<List<String>> _getChildren(String folder, bool addFolder) async {
  List<String> paths = [];
  Directory directory = Directory(folder);
  await for (FileSystemEntity entity in directory.list(recursive: true)) {
    if (addFolder && entity is Directory) {
      paths.add(entity.path);
    }
    if (!addFolder && entity is File) {
      paths.add(entity.path);
    }
  }
  return paths;
}
