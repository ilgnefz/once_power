import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/extension.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/src/rust/api/file_info.dart';
import 'package:once_power/src/rust/api/models.dart';
import 'package:once_power/util/notification.dart';
import 'package:path/path.dart' as path;

Future<void> formatXFile(WidgetRef ref, List<XFile> files) async {
  final List<String> paths = files.map((e) => e.path).toList();
  await addFileInfo(ref, paths);
}

Future<void> formatFolder(WidgetRef ref, List<String> folders) async {
  bool addFolder = ref.read(isAddFolderProvider);
  bool addSubfolder = ref.read(isAddSubfolderProvider);
  List<String> paths = [];
  for (String folder in folders) {
    paths.addAll(await handleFolder(folder, addFolder, addSubfolder));
  }
  if (paths.isEmpty) return showEmptyNotification();
  await addFileInfo(ref, paths);
}

Future<void> formatPath(WidgetRef ref, List<String> paths) async {
  List<String> files = [];
  bool addFolder = ref.read(isAddFolderProvider);
  bool addSubfolder = ref.read(isAddSubfolderProvider);
  for (String p in paths) {
    bool isFile = await FileSystemEntity.isFile(p);
    isFile
        ? files.add(p)
        : files.addAll(await handleFolder(p, addFolder, addSubfolder));
  }
  if (files.isEmpty) return showEmptyNotification();
  await addFileInfo(ref, files);
}

Future<List<String>> handleFolder(
  String folder,
  bool addFolder,
  bool addSubfolder,
) async {
  List<String> list = [];
  if (addFolder) {
    addSubfolder
        ? list.addAll(await getAllPath(folder, true))
        : list.add(folder);
  } else {
    list.addAll(await getAllPath(folder, false));
  }
  return list;
}

Future<List<String>> getAllPath(String folder, bool addSubfolder) async {
  Directory directory = Directory(folder);
  List<String> children = <String>[];
  await for (FileSystemEntity entity in directory.list(recursive: true)) {
    final FileSystemEntityType type = await FileSystemEntity.type(entity.path);
    if (type == FileSystemEntityType.file && !addSubfolder) {
      String extension = path.extension(entity.path);
      String ext = extension.isEmpty ? extension : extension.substring(1);
      if (!AppExtension.filter.contains(ext)) children.add(entity.path);
    } else if (type == FileSystemEntityType.directory && addSubfolder) {
      children.add(entity.path);
    }
  }
  return children;
}

Future<void> addFileInfo(WidgetRef ref, List<String> paths) async {
  Stopwatch stopwatch = Stopwatch()..start();
  bool isAppend = ref.read(isAppendModeProvider);
  if (!isAppend) ref.read(fileListProvider.notifier).clear();
  int total = paths.length;
  ref.read(totalProvider.notifier).update(total);
  final cProvider = ref.read(countProvider.notifier);
  cProvider.reset();
  ref.read(isApplyingProvider.notifier).start();
  ref.read(isLoadingProvider.notifier).start();
  // ================= Start =================
  // int len = paths.length;
  // int listCount = len ~/ 100;
  final provider = ref.read(fileListProvider.notifier);
  // List<FileInfo> list = [];
  bool tooLength = total > 200;
  List<FileInfo> list = tooLength
      ? getListPool(paths: paths)
      : getList(paths: paths);
  // int count = 1, batch = (total ~/ 10).clamp(10, 50);
  // await for (final file in stream) {
  //   if (count == 1 || count % batch == 0) cProvider.updateValue(count);
  //   list.add(file);
  //   count++;
  // }
  if (tooLength) list = sortFileInfoByPaths(paths: paths, fileInfoList: list);
  cProvider.updateValue(paths.length);
  provider.insertLast(list);
  // ================== End ==================
  if (ref.read(isViewModeProvider) &&
      !ref.read(currentModeProvider).isOrganize) {
    filterFile(ref);
  }
  stopwatch.stop();
  double cost = stopwatch.elapsedMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  updateName(ref);
  ref.read(isApplyingProvider.notifier).finish();
  ref.read(isLoadingProvider.notifier).finish();
}

void filterFile(WidgetRef ref) {
  final FileList provider = ref.read(fileListProvider.notifier);
  final int before = ref.watch(fileListProvider).length;
  provider.removeOtherClassify([FileType.image, FileType.video]);
  final int after = ref.watch(fileListProvider).length;
  showFilterNotification(before - after);
  provider.generateVideoThumbnails();
}
