import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/utils/storage.dart';
import 'package:path/path.dart' as path;

import 'notification.dart';
import 'update.dart';

void openFileLocation(String filePath) async {
  String dirPath = path.dirname(filePath);
  try {
    // 优化文件检查：只检查一次文件系统类型
    FileSystemEntityType entityType = await FileSystemEntity.type(filePath);
    if (entityType == FileSystemEntityType.notFound) {
      return showOpenErrorNotification(tr(AppL10n.errOpenInfo), 5);
    }

    if (Platform.isWindows) {
      await Process.run('explorer.exe', ['/select,', filePath]);
    } else if (Platform.isMacOS) {
      await Process.start('open', ['-R', filePath]);
    } else {
      await Process.start('xdg-open', [dirPath]);
    }
  } catch (e) {
    debugPrint('打开文件位置失败: $e');
    showOpenErrorNotification(e.toString());
  }
}

void insertFirst(WidgetRef ref, List<FileInfo> files) {
  ref.read(fileListProvider.notifier).insertFirst(files);
  updateName(ref);
}

void insertCenter(WidgetRef ref, List<FileInfo> files) {
  ref.read(fileListProvider.notifier).insertCenter(files);
  updateName(ref);
}

void insertLast(WidgetRef ref, List<FileInfo> files) {
  ref.read(fileListProvider.notifier).insertLast(files);
  updateName(ref);
}

void insertPosition(WidgetRef ref, int index, List<FileInfo> files) {
  ref.read(fileListProvider.notifier).insertPosition(index, files);
  updateName(ref);
}

void toggleMultipleCheck(WidgetRef ref, List<FileInfo> files) {
  for (FileInfo e in files) {
    ref.read(fileListProvider.notifier).updateCheck(e.id, !e.checked);
  }
  updateName(ref);
}

void removeOne(WidgetRef ref, FileInfo file) {
  ref.read(fileListProvider.notifier).remove(file);
  updateName(ref);
}

void removeFolder(WidgetRef ref, List<FileInfo> files) {
  Set<String> folders = {};
  for (FileInfo e in files) {
    folders.add(e.parent);
  }
  for (String e in folders) {
    ref.read(fileListProvider.notifier).removeFolder(e);
  }
  updateName(ref);
}

void removeMultiple(WidgetRef ref, List<FileInfo> files) {
  for (FileInfo e in files) {
    ref.read(fileListProvider.notifier).remove(e);
  }
  updateName(ref);
}

void setGroup(BuildContext context, WidgetRef ref, String group) {
  List<FileInfo> files = ref.watch(sortSelectListProvider);
  for (FileInfo e in files) {
    group = e.group == group ? '' : group;
    ref.read(fileListProvider.notifier).updateGroup(e.id, group);
  }
  updateName(ref);
  if (context.mounted) Navigator.of(context).pop();
}

Future<void> removeGroup(WidgetRef ref, String group) async {
  List<String> list = StorageUtil.getStringList(AppKeys.groupList);
  list.remove(group);
  await StorageUtil.setStringList(AppKeys.groupList, list);
  List<FileInfo> files = ref.watch(fileListProvider);
  for (FileInfo e in files) {
    if (e.group == group) {
      ref.read(fileListProvider.notifier).updateGroup(e.id, '');
    }
  }
  updateName(ref);
}

(Map<String, dynamic>, int) calculateIndex(
  Map<String, dynamic> classifyMap,
  List<String> keys,
  FileInfo file,
) {
  Map<String, dynamic> currentLevel = classifyMap;

  for (int i = 0; i < keys.length; i++) {
    final key = keys[i];
    final isLastKey = i == keys.length - 1;

    if (isLastKey) {
      if (currentLevel[key] is Map<String, dynamic>) {
        final files = currentLevel[key]['_files'] as List<FileInfo>;
        if (!files.contains(file)) files.add(file);
      } else {
        if (!currentLevel.containsKey(key)) currentLevel[key] = <FileInfo>[];
        final files = currentLevel[key] as List<FileInfo>;
        if (!files.contains(file)) files.add(file);
      }
    } else {
      if (currentLevel.containsKey(key) &&
          currentLevel[key] is List<FileInfo>) {
        final existingFiles = currentLevel[key] as List<FileInfo>;
        currentLevel[key] = {'_files': existingFiles};
      }

      if (!currentLevel.containsKey(key)) {
        currentLevel[key] = <String, dynamic>{};
      }
      currentLevel = currentLevel[key] as Map<String, dynamic>;
    }
  }

  final lastKey = keys.last;
  if (currentLevel[lastKey] is Map<String, dynamic>) {
    final files = currentLevel[lastKey]['_files'] as List<FileInfo>;
    return (classifyMap, files.indexOf(file));
  }
  final files = currentLevel[lastKey] as List<FileInfo>;
  return (classifyMap, files.indexOf(file));
}
