import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/enums/sort.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/storage.dart';

import 'list.dart';
import 'notification.dart';

List<FileInfo> tempSortSelectList = [];
MovePosition tempMP = MovePosition.idle;

void toThePosition(
  WidgetRef ref,
  List<FileInfo> selectList,
  Function(List<FileInfo> list) insertFunction,
  int targetIndex,
  MovePosition mp,
) {
  List<FileInfo> files = ref.watch(sortListProvider);
  if (listEquals(tempSortSelectList, selectList) && tempMP == mp) return;
  tempMP = mp;
  tempSortSelectList.clear();
  tempSortSelectList.addAll(selectList);
  if (selectList.length == 1) {
    int index = files.indexWhere((e) => e == selectList.single);
    if (index == targetIndex) return;
  }
  for (FileInfo file in selectList) {
    removeOne(ref, file);
  }
  insertFunction(selectList);
  ref.read(currentSortProvider.notifier).update(SortType.defaultSort);
}

void toTheFirst(WidgetRef ref, List<FileInfo> selectList) {
  toThePosition(
    ref,
    selectList,
    (list) => insertFirst(ref, list),
    0,
    MovePosition.first,
  );
}

void toTheCenter(WidgetRef ref, List<FileInfo> selectList) {
  List<FileInfo> files = ref.watch(sortListProvider);
  toThePosition(
    ref,
    selectList,
    (list) => insertCenter(ref, list),
    files.length ~/ 2,
    MovePosition.center,
  );
}

void toTheLast(WidgetRef ref, List<FileInfo> selectList) {
  List<FileInfo> files = ref.watch(sortListProvider);
  toThePosition(
    ref,
    selectList,
    (list) => insertLast(ref, list.reversed.toList()),
    files.length - 1,
    MovePosition.last,
  );
}

void suspenseFileList(WidgetRef ref, List<FileInfo> selectList) async {
  if (selectList.length < ref.watch(totalProvider)) {
    List<FileInfo> cache = [];
    for (FileInfo file in selectList) {
      cache.add(file);
      removeOne(ref, file);
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
