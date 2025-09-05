import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';

import 'update.dart';

void selectGroup(WidgetRef ref, String group) {
  ref.read(sortSelectListProvider.notifier).clear();
  List<FileInfo> list = ref.watch(sortListProvider);
  for (FileInfo e in list) {
    if (e.group != group) continue;
    ref.read(sortSelectListProvider.notifier).add(e);
  }
  updateName(ref);
}

void selectPath(WidgetRef ref, String folder) {
  ref.read(sortSelectListProvider.notifier).clear();
  List<FileInfo> list = ref.watch(sortListProvider);
  for (FileInfo e in list) {
    if (e.parent != folder) continue;
    ref.read(sortSelectListProvider.notifier).add(e);
  }
  updateName(ref);
}

void selectAll(WidgetRef ref) {
  ref.read(selectAllProvider.notifier).update();
  updateName(ref);
}
