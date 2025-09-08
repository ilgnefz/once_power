import 'dart:async';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/ext.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/utils/task_tracker.dart';
import 'package:once_power/utils/verify.dart';
import 'package:path/path.dart' as path;

import 'notification.dart';

Future<void> formatXFile(WidgetRef ref, List<XFile> files) async {
  final List<String> paths = files.map((e) => e.path).toList();
  await addFileInfo(ref, paths);
}

Future<void> formatFolder(WidgetRef ref, List<String?> folders) async {
  List<String> paths = await handleFolder(ref, folders);
  if (paths.isEmpty) return showEmptyNotification();
  await addFileInfo(ref, paths);
}

Future<void> formatPath(WidgetRef ref, List<String> paths) async {
  List<String> files = [];
  List<String> folders = [];
  for (String p in paths) {
    bool isFile = await FileSystemEntity.isFile(p);
    if (isFile) files.add(p);
    if (!isFile) folders.add(p);
  }
  if (folders.isEmpty && files.isEmpty) return showEmptyNotification();
  if (folders.isNotEmpty) files.addAll(await handleFolder(ref, folders));
  if (files.isNotEmpty) await addFileInfo(ref, files);
}

Future<List<String>> handleFolder(WidgetRef ref, List<String?> folders) async {
  bool addFolder = ref.watch(isAddFolderProvider);
  bool addSubfolder = ref.watch(isAddSubfolderProvider);
  List<String> paths = [];
  for (String? folder in folders) {
    if (!addFolder) {
      paths.addAll(await getAllPath(folder!, false));
    } else {
      paths.add(folder!);
      if (addSubfolder) paths.addAll(await getAllPath(folder, true));
    }
  }
  return paths;
}

Future<List<String>> getAllPath(String folder, bool addSubfolder) async {
  Directory directory = Directory(folder);
  List<String> children = <String>[];
  await for (FileSystemEntity entity in directory.list(recursive: true)) {
    bool isFile = await FileSystemEntity.isFile(entity.path);
    bool isDir = await FileSystemEntity.isDirectory(entity.path);
    if (isFile && !addSubfolder) {
      String extension = path.extension(entity.path);
      String ext = extension.isEmpty ? extension : extension.substring(1);
      if (!filter.contains(ext)) children.add(entity.path);
    }
    if (isDir && addSubfolder) children.add(entity.path);
  }
  return children;
}

Future<void> addFileInfo(WidgetRef ref, List<String> paths) async {
  Stopwatch stopwatch = Stopwatch()..start();
  ref.read(isApplyingProvider.notifier).start();
  bool isAppend = ref.watch(isAppendModeProvider);
  if (!isAppend) ref.read(fileListProvider.notifier).clear();
  ref.read(totalProvider.notifier).update(paths.length);
  ref.read(countProvider.notifier).reset();
  await processFilesWithConcurrence(ref, paths);
  if (isShowView(ref)) filterFile(ref);
  stopwatch.stop();
  double cost = stopwatch.elapsedMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  ref.read(isApplyingProvider.notifier).finish();
}

Future<void> processFilesWithConcurrence(
  WidgetRef ref,
  List<String> paths,
) async {
  const int maxConcurrent = AppNum.batchSize; // 控制并发数量，防止资源耗尽
  final TaskTracker taskTracker = TaskTracker(); // 使用TaskTracker来跟踪任务状态
  for (String path in paths) {
    // 如果已达到最大并发数，等待一个任务完成
    if (taskTracker.activeTasksCount >= maxConcurrent) {
      await Future.any(taskTracker.activeTasks); // 等待任意一个任务完成
      taskTracker.cleanCompletedTasks(); // 清理已完成的任务
    }
    Future<void> task = _processSingleFile(ref, path); // 创建一个处理单个文件的任务
    taskTracker.addTask(task); // 添加到任务跟踪器
  }
  // 等待所有剩余任务完成
  if (taskTracker.activeTasks.isNotEmpty) {
    await Future.wait(taskTracker.activeTasks);
  }
}

/// 处理单个文件
Future<void> _processSingleFile(WidgetRef ref, String filePath) async {
  try {
    ref.read(countProvider.notifier).update();
    ref.read(currentFileProvider.notifier).update(filePath);
    ref.read(currentFileProvider.notifier).update(filePath);
    if (isExist(ref, filePath)) return;
    FileInfo fileInfo = await generateFileInfo(filePath);
    ref.read(fileListProvider.notifier).add(fileInfo);
  } catch (e) {
    debugPrint('处理文件 $filePath 时出错: $e');
  }
}

Future<FileInfo> generateFileInfo(String filePath) async {
  String name = getFileName(filePath);
  String ext = getExtension(filePath);
  if (name.startsWith('.') && ext.isEmpty) {
    (ext, name) = (name.substring(1), '');
  }
  FileStat stat = await File(filePath).stat();
  FileClassify type = getFileClassify(ext);
  int size = type.isFolder ? await calculateSize(filePath) : stat.size;
  DateTime? exifDate;
  Resolution? resolution;
  FileMetaInfo? metaInfo;
  Uint8List? thumbnail;
  if (type.isAudio) metaInfo = getAudioInfo(filePath);
  if (type.isImage) {
    List<Object?> results = await Future.wait([
      getExifDate(filePath),
      getImageDimensions(filePath),
    ]);
    exifDate = results[0] as DateTime?;
    resolution = results[1] as Resolution?;
  }
  if (type.isVideo) resolution = getVideoDimensions(filePath);
  return FileInfo(
    id: nanoid(10),
    name: name,
    newName: name,
    parent: path.dirname(filePath),
    path: filePath,
    ext: ext,
    newExt: ext,
    beforePath: filePath,
    createdDate: stat.changed,
    modifiedDate: stat.modified,
    accessedDate: stat.accessed,
    exifDate: exifDate,
    type: type,
    size: size,
    resolution: resolution,
    metaInfo: metaInfo,
    thumbnail: thumbnail,
  );
}

void filterFile(WidgetRef ref) {
  if (isShowView(ref)) {
    final FileList provider = ref.read(fileListProvider.notifier);
    final int before = ref.watch(fileListProvider).length;
    provider.removeOtherClassify([FileClassify.image, FileClassify.video]);
    final int after = ref.watch(fileListProvider).length;
    showFilterNotification(before - after);
  }
}
