import 'dart:io';
import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/extension.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/src/rust/api/file_info.dart';
import 'package:once_power/src/rust/api/file_meta.dart';
import 'package:once_power/src/rust/api/file_type.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/util/notification.dart';
import 'package:path/path.dart' as path;

Future<void> formatXFile(WidgetRef ref, List<XFile> files) async {
  final List<String> paths = files.map((e) => e.path).toList();
  await addFileInfo(ref, paths);
}

Future<void> formatFolder(WidgetRef ref, List<String> folders) async {
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

Future<List<String>> handleFolder(WidgetRef ref, List<String> folders) async {
  bool addFolder = ref.watch(isAddFolderProvider);
  bool addSubfolder = ref.watch(isAddSubfolderProvider);
  final List<Future<List<String>>> futures = folders.map((folder) async {
    final List<String> folderPaths = <String>[];
    if (!addFolder) {
      folderPaths.addAll(await getAllPath(folder, false));
    } else {
      if (addSubfolder) folderPaths.addAll(await getAllPath(folder, true));
    }
    return folderPaths;
  }).toList();
  final List<List<String>> results = await Future.wait(futures);
  return results.expand((paths) => paths).toList();
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
  bool isAppend = ref.watch(isAppendModeProvider);
  if (!isAppend) ref.read(fileListProvider.notifier).clear();
  ref.read(totalProvider.notifier).update(paths.length);
  ref.read(countProvider.notifier).reset();
  ref.read(isApplyingProvider.notifier).start();
  await processFilesWithConcurrence(ref, paths);
  if (ref.watch(isViewModeProvider)) filterFile(ref);
  stopwatch.stop();
  double cost = stopwatch.elapsedMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  ref.read(isApplyingProvider.notifier).finish();
  updateName(ref);
}

Future<void> processFilesWithConcurrence(
  WidgetRef ref,
  List<String> paths, {
  int concurrency = 8,
}) async {
  if (paths.isEmpty) return;
  int index = 0;
  final int total = paths.length;
  Future<void> worker() async {
    while (true) {
      final int current = index;
      if (current >= total) return;
      final String filePath = paths[current];
      index++;
      Set<String> filePaths = ref
          .read(fileListProvider)
          .map((e) => e.path)
          .toSet();
      if (filePaths.contains(filePath)) return;
      final FileInfo fileInfo = await generateFileInfo(filePath);
      ref.read(fileListProvider.notifier).add(fileInfo);
    }
  }

  final workers = List.generate(concurrency, (_) => worker());
  await Future.wait(workers);
}

Future<FileInfo> generateFileInfo(String filePath) async {
  RFileInfo fileInfo = getFileInfo(filePath: filePath);
  String name = fileInfo.name;
  String ext = fileInfo.ext;
  if (ext.isEmpty && name.startsWith('.')) {
    (name, ext) = ('', name.substring(1));
  }
  FileType type = fileInfo.isDir ? FileType.folder : getFileType(ext);
  FileMetaInfo? metaInfo;
  Resolution? resolution;
  Uint8List? thumbnail;
  if (type.isAudio) metaInfo = getAudioInfo(filePath);
  if (type.isImage) {
    resolution = await getImageDimensions(filePath);
    PhotoMetaInfo? photoMetaInfo = getImageMetaInfo(imagePath: filePath);
    if (photoMetaInfo != null) {
      String? captureStr = photoMetaInfo.capture;
      DateInfo? capture = captureStr == null
          ? null
          : getDateInfo(DateTime.tryParse(captureStr));
      metaInfo = FileMetaInfo(
        make: photoMetaInfo.make ?? '',
        model: photoMetaInfo.model ?? '',
        capture: capture,
        latitude: photoMetaInfo.latitude,
        longitude: photoMetaInfo.longitude,
      );
    }
  }
  if (type.isVideo) {
    (Resolution, FileMetaInfo) result = await getVideoInfo(filePath);
    (resolution, metaInfo) = result;
  }
  return FileInfo(
    id: fileInfo.id,
    name: name,
    newName: name,
    extension: ext,
    newExtension: ext,
    parent: fileInfo.parent,
    path: filePath,
    tempPath: '',
    beforePath: filePath,
    createdDate: getDateInfo(intToDateTime(fileInfo.createTime))!,
    modifiedDate: getDateInfo(intToDateTime(fileInfo.modifyTime))!,
    accessedDate: getDateInfo(intToDateTime(fileInfo.accessTime))!,
    metaInfo: metaInfo,
    resolution: resolution,
    thumbnail: thumbnail,
    type: type,
    size: fileInfo.size.toInt(),
  );
}

void filterFile(WidgetRef ref) {
  final FileList provider = ref.read(fileListProvider.notifier);
  final int before = ref.watch(fileListProvider).length;
  provider.removeOtherClassify([FileType.image, FileType.video]);
  final int after = ref.watch(fileListProvider).length;
  showFilterNotification(before - after);
}
