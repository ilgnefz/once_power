import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/sort_enum.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/list.dart';
import 'package:once_power/providers/progress.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/utils/verify.dart';
import 'package:path/path.dart' as path;
import 'package:string_util_xx/StringUtilxx.dart';

import 'list.dart';
import 'notification.dart';

List<FileInfo> tempSortSelectList = [];
MovePosition tempMP = MovePosition.idle;

/// 将选中的文件列表移动到指定位置的核心方法
/// [ref] Riverpod 的 WidgetRef，用于访问和修改状态
/// [selectList] 需要移动的文件信息列表
/// [insertFunction] 插入位置的回调函数（由具体移动目标决定插入方式）
/// [targetIndex] 目标位置的索引（用于判断是否需要跳过重复操作）
/// [movePosition] 移动位置类型（枚举值，用于避免重复操作）
void toThePosition(
  WidgetRef ref,
  List<FileInfo> selectList,
  Function(List<FileInfo> list) insertFunction,
  int targetIndex,
  MovePosition mp,
) {
  // 获取当前排序的文件列表
  List<FileInfo> files = ref.watch(sortListProvider);

  // 跳过重复操作：如果当前选中列表和上一次操作的列表相同，且移动类型未变，则不执行
  if (listEquals(tempSortSelectList, selectList) && tempMP == mp) {
    return;
  }

  // 更新临时变量记录当前操作状态
  tempMP = mp;
  tempSortSelectList.clear();
  tempSortSelectList.addAll(selectList);

  // 单文件移动时，检查是否已在目标位置（避免无效操作）
  if (selectList.length == 1) {
    int index = files.indexWhere((e) => e == selectList.single);
    if (index == targetIndex) return;
  }

  // 从当前列表中移除所有选中文件
  for (FileInfo file in selectList) {
    removeOne(ref, file.id);
  }

  // 调用插入函数将文件插入目标位置（由具体移动场景决定插入方式）
  insertFunction(selectList);

  // 重置排序类型为默认（确保后续操作基于原始顺序）
  ref.read(fileSortTypeProvider.notifier).update(SortType.defaultSort);
}

void toTheFirst(WidgetRef ref, List<FileInfo> selectList) {
  toThePosition(
      ref, selectList, (list) => insertFirst(ref, list), 0, MovePosition.first);
}

void toTheCenter(WidgetRef ref, List<FileInfo> selectList) {
  List<FileInfo> files = ref.watch(sortListProvider);
  toThePosition(ref, selectList, (list) => insertCenter(ref, list),
      files.length ~/ 2, MovePosition.center);
}

void toTheLast(WidgetRef ref, List<FileInfo> selectList) {
  List<FileInfo> files = ref.watch(sortListProvider);
  toThePosition(
      ref,
      selectList,
      (list) => insertLast(ref, list.reversed.toList()),
      files.length - 1,
      MovePosition.last);
}

void suspenseFileList(WidgetRef ref, List<FileInfo> selectList) async {
  if (selectList.length < ref.watch(totalProvider)) {
    List<FileInfo> cache = [];
    for (FileInfo file in selectList) {
      cache.add(file);
      removeOne(ref, file.id);
    }
    await StorageUtil.setFileList(AppKeys.suspenseFileList, cache);
  } else {
    showSuspenseErrorNotification();
  }
}

void toTheFront(WidgetRef ref, FileInfo file) {
  List<FileInfo> files = ref.watch(sortListProvider);
  int index = files.indexWhere((e) => e == file);
  List<FileInfo> list = StorageUtil.getFileList(AppKeys.suspenseFileList);
  if (index == 0) {
    insertFirst(ref, list);
  } else {
    insertPosition(ref, index, list);
  }
  StorageUtil.remove(AppKeys.suspenseFileList);
  ref.read(sortSelectListProvider.notifier).clear();
  ref.read(sortSelectListProvider.notifier).addAll(list);
}

void toTheBehind(WidgetRef ref, FileInfo file) {
  List<FileInfo> files = ref.watch(sortListProvider);
  int index = files.indexWhere((e) => e == file);
  List<FileInfo> list = StorageUtil.getFileList(AppKeys.suspenseFileList);
  if (index == files.length) {
    insertLast(ref, list);
  } else {
    insertPosition(ref, index + 1, list);
  }
  StorageUtil.remove(AppKeys.suspenseFileList);
  ref.read(sortSelectListProvider.notifier).clear();
  ref.read(sortSelectListProvider.notifier).addAll(list);
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
  ref.read(sortSelectListProvider.notifier).clear();
  updateName(ref);
}

void openFileLocation(String filePath) async {
  final dirPath = path.dirname(filePath);
  try {
    if (Platform.isWindows) {
      bool isFile = await FileSystemEntity.isFile(filePath);
      if (isFile && !await File(filePath).exists()) {
        return showOpenErrorNotification(S.current.notExistError, 5);
      }
      if (!isFile && !await Directory(filePath).exists()) {
        return showOpenErrorNotification(S.current.notExistError, 5);
      }
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
    chineseList.sort((a, b) => StringUtilxx_c.compareExtend(b.name, a.name));
    otherList.sort((a, b) => b.name.compareTo(a.name));
    return [...chineseList, ...otherList];
  }
  chineseList.sort((a, b) => StringUtilxx_c.compareExtend(a.name, b.name));
  otherList.sort((a, b) => a.name.compareTo(b.name));
  return [...otherList, ...chineseList];
}

List<DateTime> sortDateTime(FileInfo file) {
  List<DateTime> list = [file.createdDate, file.modifiedDate];
  if (file.exifDate != null) list.add(file.exifDate!);
  list.sort();
  return list;
}
