import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/sort.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/util/notification.dart';
import 'package:once_power/util/selection.dart';

import 'list.dart';

List<FileInfo> _tempSortSelectList = [];
MovePosition _tempMP = MovePosition.idle;

void toThePosition(
  WidgetRef ref,
  List<FileInfo> selectList,
  Function(List<FileInfo> list) insertFunction,
  int targetIndex,
  MovePosition mp,
) {
  List<FileInfo> files = ref.read(sortListProvider);
  if (ref.read(currentSortProvider) != SortType.defaultSort) {
    ref.read(fileListProvider.notifier).addAll(files);
    ref.read(currentSortProvider.notifier).update(SortType.defaultSort);
  }
  if (listEquals(_tempSortSelectList, selectList) && _tempMP == mp) return;
  _tempMP = mp;
  _tempSortSelectList.clear();
  _tempSortSelectList.addAll(selectList);
  if (selectList.length == 1) {
    int index = files.indexWhere((e) => e == selectList.single);
    if (index == targetIndex) return;
  }
  for (FileInfo file in selectList) {
    removeOne(ref, file);
  }
  insertFunction(selectList);
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
  List<FileInfo> files = ref.read(sortListProvider);
  toThePosition(
    ref,
    selectList,
    (list) => insertCenter(ref, list),
    files.length ~/ 2,
    MovePosition.center,
  );
}

void toTheLast(WidgetRef ref, List<FileInfo> selectList) {
  List<FileInfo> files = ref.read(sortListProvider);
  toThePosition(
    ref,
    selectList,
    (list) => insertLast(ref, list.reversed.toList()),
    files.length - 1,
    MovePosition.last,
  );
}

void stashFileList(WidgetRef ref, List<FileInfo> selectList) async {
  List<FileInfo> all = ref.read(sortListProvider);
  if (selectList.length < all.length) {
    List<FileInfo> stashList = [];
    for (FileInfo file in selectList) {
      stashList.add(file);
      all.remove(file);
    }
    StashState.addAll(stashList);
    ref.read(currentSortProvider.notifier).update(SortType.defaultSort);
    ref.read(fileListProvider.notifier).addAll(all);
    updateName(ref);
  } else {
    showStashErrorNotification();
  }
}

void toTheFront(WidgetRef ref, FileInfo file) {
  List<FileInfo> files = ref.read(sortListProvider);
  int index = files.indexWhere((e) => e == file);
  List<FileInfo> list = StashState.list;
  if (index == 0) {
    insertFirst(ref, list);
  } else {
    insertPosition(ref, index, list);
  }
  StashState.clear();
  ref.read(sortSelectListProvider.notifier).clear();
  ref.read(sortSelectListProvider.notifier).addAll(list);
}

void toTheBehind(WidgetRef ref, FileInfo file) {
  List<FileInfo> files = ref.read(sortListProvider);
  int index = files.indexWhere((e) => e == file);
  List<FileInfo> list = StashState.list;
  if (index == files.length) {
    insertLast(ref, list);
  } else {
    insertPosition(ref, index + 1, list);
  }
  StashState.clear();
  ref.read(sortSelectListProvider.notifier).clear();
  ref.read(sortSelectListProvider.notifier).addAll(list);
}
