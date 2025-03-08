import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/progress.dart';
import 'package:once_power/utils/verify.dart';

import '../models/file_enum.dart';

void selectAll(WidgetRef ref) {
  ref.read(selectAllProvider.notifier).update();
  updateName(ref);
}

void toggleCheck(WidgetRef ref, String id) {
  ref.read(fileListProvider.notifier).check(id);
  updateName(ref);
}

void removeOne(WidgetRef ref, String id) {
  ref.read(fileListProvider.notifier).remove(id);
  updateName(ref);
}

void removeAll(WidgetRef ref) {
  ref.read(fileListProvider.notifier).clear();
  ref.read(countProvider.notifier).clear();
  ref.read(totalProvider.notifier).clear();
  ref.read(costProvider.notifier).clear();
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

void filterFile(BuildContext context, WidgetRef ref) {
  if (isViewNoOrganize(ref)) {
    final FileList provider = ref.read(fileListProvider.notifier);
    final int before = ref.watch(fileListProvider).length;
    provider.removeOtherClassify([FileClassify.image, FileClassify.video]);
    final int after = ref.watch(fileListProvider).length;
    showFilterNotification(before - after);
  }
}
