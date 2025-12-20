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

List<DateInfo> sortDateTime(FileInfo file) {
  List<DateInfo> list = [file.createdDate, file.modifiedDate];
  DateInfo? captureDate = file.metaInfo?.capture;
  if (captureDate != null) list.add(captureDate);
  list.sort((a, b) => a.date.compareTo(b.date));
  return list;
}
