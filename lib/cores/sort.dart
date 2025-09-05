import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enums/sort.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';

import 'update.dart';

void reorderList(
  WidgetRef ref,
  List<FileInfo> files,
  int oldIndex,
  int newIndex,
) {
  if (ref.watch(currentSortProvider) != SortType.defaultSort) {
    ref.read(currentSortProvider.notifier).update(SortType.defaultSort);
    ref.read(fileListProvider.notifier).addAll(files);
  }
  FileInfo item = files.elementAt(oldIndex);
  ref.read(fileListProvider.notifier).removeAt(oldIndex);
  ref.read(fileListProvider.notifier).insertAt(newIndex, item);
  ref.read(sortSelectListProvider.notifier).clear();
  updateName(ref);
}

List<DateTime> sortDateTime(FileInfo file) {
  List<DateTime> list = [file.createdDate, file.modifiedDate];
  if (file.exifDate != null) list.add(file.exifDate!);
  list.sort();
  return list;
}
