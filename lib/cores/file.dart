import 'dart:collection';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_size_getter/image_size_getter.dart';
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
import 'package:pinyin/pinyin.dart';

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
Future<List<String>> getAllPath(String folder,
    [bool addSubfolder = false]) async {
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
  bool isAppend = ref.watch(isAppendModeProvider);
  if (!isAppend) ref.read(fileListProvider.notifier).clear();
  ref.read(totalProvider.notifier).update(paths.length);
  final stopwatch = Stopwatch()..start();

  const maxConcurrent = 10;
  final processingQueue = Queue<Future<void>>();

  for (final p in paths) {
    if (isViewNoOrganize(ref) && !isImgVideo(p)) continue;
    if (isExist(ref, p)) continue;

    if (processingQueue.length >= maxConcurrent) {
      await processingQueue.removeFirst();
    }

    final future = _processSingleFile(ref, p).then((fileInfo) {
      if (fileInfo != null) {
        ref.read(fileListProvider.notifier).add(fileInfo);
        ref.read(countProvider.notifier).update();
      }
    });

    processingQueue.add(future);
    // await Future.delayed(const Duration(microseconds: 1));
  }

  await Future.wait(processingQueue);

  if (isViewNoOrganize(ref)) {
    showFilterNotification(paths.length - ref.watch(countProvider));
  }
  stopwatch.stop();
  double cost = stopwatch.elapsedMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  updateName(ref);
}

Future<FileInfo?> _processSingleFile(WidgetRef ref, String p) async {
  try {
    if (isViewNoOrganize(ref) && !isImgVideo(p)) return null;
    if (isExist(ref, p)) return null;
    return await generateFileInfo(ref, p);
  } catch (e) {
    debugPrint('文件处理失败: $p, 错误: $e');
    return null;
  }
}

Future<FileInfo> generateFileInfo(WidgetRef ref, String filePath) async {
  String id = nanoid(10);
  String name = getPathName(filePath);
  String phonetic = isChinese(name) ? PinyinHelper.getPinyinE(name) : name;
  String parent = path.dirname(filePath);
  DateTime? exifDate;
  final stat = await File(filePath).stat();
  DateTime createdDate = stat.changed;
  DateTime modifyDate = stat.modified;
  String extension = getExtension(filePath);
  FileClassify type = getFileClassify(extension);
  if (type.isImage) exifDate = await getExifDate(filePath);
  int size = await calculateSize(filePath);
  Size? dimensions = switch (type) {
    FileClassify.image => await getImageDimensions(filePath),
    FileClassify.video => await getVideoDimensions(filePath),
    _ => null,
  };
  return FileInfo(
    id: id,
    name: name,
    phonetic: phonetic,
    newName: name,
    parent: parent,
    filePath: filePath,
    tempPath: '',
    extension: extension,
    newExtension: extension,
    beforePath: filePath,
    createdDate: createdDate,
    modifiedDate: modifyDate,
    exifDate: exifDate,
    type: type,
    size: size,
    resolution: dimensions,
    group: '',
    checked: true,
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
Future<InfoDetail?> checkFile(WidgetRef ref, List<FileInfo> list, FileInfo file,
    [bool isUndo = false]) async {
  String newNameWithExt = isUndo
      ? path.dirname(file.beforePath)
      : getNameWithExt(file.newName, file.newExtension);
  String newPath =
      isUndo ? file.beforePath : path.join(file.parent, newNameWithExt);
  bool isExist = await checkExist(ref, list, newPath, isUndo: isUndo);
  if (isExist) {
    return InfoDetail(
      file: getNameWithExt(file.name, file.extension),
      message: ' ${S.current.existsError(newNameWithExt)}',
    );
  }
  return null;
}
