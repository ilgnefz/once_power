import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/list.dart';
import 'package:once_power/providers/progress.dart';
import 'package:once_power/utils/storage.dart';
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

void toggleMultipleCheck(WidgetRef ref, List<FileInfo> files) {
  for (FileInfo e in files) {
    ref.read(fileListProvider.notifier).check(e.id);
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

void removeOne(WidgetRef ref, String id) {
  ref.read(fileListProvider.notifier).remove(id);
  updateName(ref);
}

void removeMultiple(WidgetRef ref, List<FileInfo> files) {
  for (FileInfo e in files) {
    ref.read(fileListProvider.notifier).remove(e.id);
  }
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
