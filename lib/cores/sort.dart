import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/sort_enum.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/list.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/utils/verify.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'list.dart';
import 'notification.dart';
import 'rename.dart';

List<FileInfo> tempSortSelectList = [];
MovePosition tempMP = MovePosition.idle;

void toThePosition(
  WidgetRef ref,
  Function(List<FileInfo> list) insertFunction,
  int targetIndex,
  MovePosition mp,
) {
  List<FileInfo> files = ref.watch(sortListProvider);
  List<FileInfo> sortSelectList = ref.watch(sortSelectListProvider);
  if (listEquals(tempSortSelectList, sortSelectList) && tempMP == mp) {
    return;
  }
  tempMP = mp;
  tempSortSelectList.clear();
  tempSortSelectList.addAll(sortSelectList);
  if (sortSelectList.length == 1) {
    int index = files.indexWhere((e) => e == sortSelectList.single);
    if (index == targetIndex) return;
  }
  for (FileInfo file in sortSelectList) {
    removeOne(ref, file.id);
  }
  insertFunction(sortSelectList);
  ref.read(fileSortTypeProvider.notifier).update(SortType.defaultSort);
}

void toTheFirst(WidgetRef ref) {
  toThePosition(ref, (list) => insertFirst(ref, list), 0, MovePosition.first);
}

void toTheCenter(WidgetRef ref) {
  List<FileInfo> files = ref.watch(sortListProvider);
  toThePosition(ref, (list) => insertCenter(ref, list), files.length ~/ 2,
      MovePosition.center);
}

void toTheLast(WidgetRef ref) {
  List<FileInfo> files = ref.watch(sortListProvider);
  toThePosition(ref, (list) => insertLast(ref, list.reversed.toList()),
      files.length - 1, MovePosition.last);
}

void reorderList(
    WidgetRef ref, List<FileInfo> files, int oldIndex, int newIndex) {
  if (ref.watch(fileSortTypeProvider) != SortType.defaultSort) {
    ref.read(fileSortTypeProvider.notifier).update(SortType.defaultSort);
    ref.read(fileListProvider.notifier).addAll(files);
  }
  FileInfo item = files.elementAt(oldIndex);
  ref.read(fileListProvider.notifier).removeAt(oldIndex);
  ref.read(fileListProvider.notifier).insertAt(newIndex, item);
  updateName(ref);
}

void openFileLocation(String filePath) async {
  final dirPath = path.dirname(filePath);
  try {
    if (Platform.isWindows) {
      // Windows 使用 explorer 选中文件
      await Process.run('explorer.exe', ['/select,', filePath]);
    } else if (Platform.isMacOS) {
      // macOS 使用 open 命令显示文件
      await Process.run('open', ['-R', filePath]);
    } else {
      // Linux 使用 xdg-open 打开父目录
      await Process.run('xdg-open', [dirPath]);
    }
  } catch (e) {
    debugPrint('打开文件位置失败: $e');
    showOpenErrorNotification(e.toString());
  }
}

// void reorderList(
//     WidgetRef ref, List<FileInfo> files, int oldIndex, int newIndex) {
//   FileInfo item = files.removeAt(oldIndex);
//   files.insert(newIndex, item);
//   ref.watch(fileListProvider);
//   ref.read(fileListProvider.notifier).clear();
//   ref.read(fileListProvider.notifier).addAll(files);
//   ref.read(fileSortTypeProvider.notifier).update(SortType.defaultSort);
//   updateName(ref);
// }

/// 处理混合语言排序
List<FileInfo> splitSortList(List<FileInfo> fileList, bool reverse) {
  List<FileInfo> chineseList = [];
  List<FileInfo> otherList = [];
  for (FileInfo e in fileList) {
    if (isChinese(e.name)) {
      chineseList.add(e);
    } else {
      otherList.add(e);
    }
  }
  if (reverse) {
    chineseList.sort((a, b) => b.phonetic.compareTo(a.phonetic));
    otherList.sort((a, b) => b.name.compareTo(a.name));
    return [...chineseList, ...otherList];
  }
  chineseList.sort((a, b) => a.phonetic.compareTo(b.phonetic));
  otherList.sort((a, b) => a.name.compareTo(b.name));
  return [...otherList, ...chineseList];
}

List<DateTime> sortDateTime(FileInfo file) {
  List<DateTime> list = [file.createdDate, file.modifiedDate];
  if (file.exifDate != null) list.add(file.exifDate!);
  list.sort();
  return list;
}
