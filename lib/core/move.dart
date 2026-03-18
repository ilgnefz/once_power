import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/sort.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/progress.dart';
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

void suspenseFileList(WidgetRef ref, List<FileInfo> selectList) async {
  if (selectList.length < ref.read(totalProvider)) {
    List<FileInfo> caches = [];
    for (FileInfo file in selectList) {
      caches.add(file);
      removeOne(ref, file);
    }
    SuspenseState.addAll(caches);
  } else {
    showSuspenseErrorNotification();
  }
}

void toTheFront(WidgetRef ref, FileInfo file) {
  List<FileInfo> files = ref.read(sortListProvider);
  int index = files.indexWhere((e) => e == file);
  List<FileInfo> list = SuspenseState.list;
  if (index == 0) {
    insertFirst(ref, list);
  } else {
    insertPosition(ref, index, list);
  }
  SuspenseState.clear();
  ref.read(sortSelectListProvider.notifier).clear();
  ref.read(sortSelectListProvider.notifier).addAll(list);
}

void toTheBehind(WidgetRef ref, FileInfo file) {
  List<FileInfo> files = ref.read(sortListProvider);
  int index = files.indexWhere((e) => e == file);
  List<FileInfo> list = SuspenseState.list;
  if (index == files.length) {
    insertLast(ref, list);
  } else {
    insertPosition(ref, index + 1, list);
  }
  SuspenseState.clear();
  ref.read(sortSelectListProvider.notifier).clear();
  ref.read(sortSelectListProvider.notifier).addAll(list);
}
