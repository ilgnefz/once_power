import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/extension.dart';
import 'package:once_power/models/file_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/progress.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/utils.dart';
import 'package:path/path.dart' as path;

import 'notification.dart';

// 处理通过按钮添加的文件
Future<void> formatXFile(WidgetRef ref, List<XFile> files) async {
  final List<String> paths = files.map((e) => e.path).toList();
  await addFileInfo(ref, paths);
}

// 处理传入来的文件夹，如果是添加文件夹就直接格式文件夹，不是就获取文件夹中的子文件
Future<void> formatFolder(WidgetRef ref, List<String?> folders) async {
  List<String> paths = await handleFolder(ref, folders);
  if (paths.isEmpty) return showEmptyNotification();
  await addFileInfo(ref, paths);
}

// 处理通过拖动添加的文件或文件夹
Future<void> formatPath(WidgetRef ref, List<String> paths) async {
  List<String> files = [];
  List<String> folders = [];
  for (String p in paths) {
    bool isFile = await FileSystemEntity.isFile(p);
    if (isFile) files.add(p);
    if (!isFile) folders.add(p);
  }
  if (folders.isNotEmpty) {
    List<String> result = await handleFolder(ref, folders);
    files.addAll(result);
  }
  if (files.isNotEmpty) {
    await addFileInfo(ref, files);
  } else {
    showEmptyNotification();
  }
}

Future<List<String>> handleFolder(WidgetRef ref, List<String?> folders) async {
  bool addFolder = ref.watch(isAddFolderProvider);
  bool addSubfolder = ref.watch(isAddSubfolderProvider);
  List<String> paths = [];
  for (String? folder in folders) {
    if (addFolder && !addSubfolder) paths.add(folder!);
    if (addFolder && addSubfolder) {
      paths.addAll([folder!, ...await getAllPath(folder, true)]);
    }
    if (!addFolder) paths.addAll(await getAllPath(folder!));
  }
  return paths;
}

// 将同步遍历改为异步流处理
Future<List<String>> getAllPath(
  String folder, [
  bool addSubfolder = false,
]) async {
  final directory = Directory(folder);
  final children = <String>[];

  await for (final entity in directory.list(recursive: true)) {
    final isFile = await FileSystemEntity.isFile(entity.path);
    final isDir = await FileSystemEntity.isDirectory(entity.path);

    if (isFile && !addSubfolder) {
      final extension = path.extension(entity.path);
      final ext = extension.isEmpty ? extension : extension.substring(1);
      if (!filter.contains(ext)) children.add(entity.path);
    }

    if (isDir && addSubfolder) children.add(entity.path);
  }
  return children;
}

Future<void> addFileInfo(WidgetRef ref, List<String> paths) async {
  final stopwatch = Stopwatch()..start();
  bool isAppend = ref.watch(isAppendModeProvider);
  if (!isAppend) ref.read(fileListProvider.notifier).clear();
  ref.read(totalProvider.notifier).update(paths.length);
  ref.read(isApplyingProvider.notifier).start();
  ref.read(showChangeProvider.notifier).reset();
  ref.read(countProvider.notifier).clear();

  // 过滤需要处理的文件路径（跳过不需要的文件）
  final validPaths = paths.where((p) {
    if (isViewNoOrganize(ref) && !isImgVideo(p)) return false;
    if (isExist(ref, p)) return false;
    return true;
  }).toList();

  // 分批次并行处理（每批处理10个文件，可根据实际调整）
  const batchSize = 10;
  for (int i = 0; i < validPaths.length; i += batchSize) {
    final batchEnd = (i + batchSize).clamp(0, validPaths.length);
    final batchPaths = validPaths.sublist(i, batchEnd);
    // 并行处理当前批次的文件（关键优化）
    final futures = batchPaths.map((p) => generateFileInfo(ref, p));
    final fileInfos = await Future.wait(futures);
    // 批量更新当前批次的文件到列表（实时显示）
    for (final fileInfo in fileInfos) {
      ref.read(fileListProvider.notifier).add(fileInfo);
      ref.read(countProvider.notifier).update();
    }
  }
  if (isViewNoOrganize(ref)) {
    showFilterNotification(paths.length - ref.watch(countProvider));
  }
  stopwatch.stop();
  double cost = stopwatch.elapsedMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  ref.read(isApplyingProvider.notifier).finish();
  updateName(ref);
}

Future<FileInfo> generateFileInfo(WidgetRef ref, String filePath) async {
  String name = getPathName(filePath);
  String extension = getExtension(filePath);
  if (name.startsWith('.') && extension.isEmpty) {
    extension = name.substring(1);
    name = '';
  }
  final stat = await File(filePath).stat();
  FileClassify type = getFileClassify(extension);
  int size = type.isFolder ? await calculateSize(filePath) : stat.size;
  DateTime? exifDate;
  Resolution? resolution;
  FileMeteInfo? metaInfo;
  if (type.isAudio) metaInfo = getMusicMetaInfo(filePath);
  if (type.isImage) {
    final results = await Future.wait([
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
    filePath: filePath,
    extension: extension,
    newExtension: extension,
    beforePath: filePath,
    createdDate: stat.changed,
    modifiedDate: stat.modified,
    accessedDate: stat.accessed,
    exifDate: exifDate,
    type: type,
    size: size,
    resolution: resolution,
    metaInfo: metaInfo,
  );
}

List<String> uploadFileContent(File file) {
  String text = file.readAsStringSync();
  List<String> list = [];
  if (text.contains('\n')) list.addAll(text.split('\r\n'));
  if (!text.contains('\n') && text.contains(' ')) {
    list.addAll(text.trim().split(' '));
  }
  return list;
}

// 如果文件存在会返回存在的错误信息
Future<InfoDetail?> checkFile(
  WidgetRef ref,
  List<FileInfo> list,
  FileInfo file, [
  bool isUndo = false,
]) async {
  String newNameWithExt = isUndo
      ? path.dirname(file.beforePath)
      : getNameWithExt(file.newName, file.newExtension);
  String newPath = isUndo
      ? file.beforePath
      : path.join(file.parent, newNameWithExt);
  bool isExist = await checkExist(ref, list, newPath, isUndo: isUndo);
  if (isExist) {
    return InfoDetail(
      file: getNameWithExt(file.name, file.extension),
      message: ' ${S.current.existsError(newNameWithExt)}',
    );
  }
  return null;
}
