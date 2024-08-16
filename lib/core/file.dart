import 'dart:io';

import 'package:exif/exif.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/utils.dart';
import 'package:path/path.dart' as path;

import 'core.dart';

void formatXFile(WidgetRef ref, List<XFile> files) async {
  bool append = ref.watch(appendModeProvider);
  if (!append) ref.read(fileListProvider.notifier).clear();
  final paths = files.map((e) => e.path).toList();
  toFormatFile(ref, paths);
}

void toFormatFile(WidgetRef ref, List<String> files) async {
  int count = 0;
  ref.read(totalProvider.notifier).update(files.length);
  bool delay = files.length > AppNum.maxFileNum;
  int startTime = DateTime.now().microsecondsSinceEpoch;
  for (var file in files) {
    count++;
    formatFile(ref, file, count);
    if (delay) await Future.delayed(const Duration(microseconds: 1));
  }
  int endTime = DateTime.now().microsecondsSinceEpoch;
  double cost = (endTime - startTime) / 1000000;
  ref.read(costProvider.notifier).update(cost);
}

void formatFile(WidgetRef ref, String filePath, [int count = 0]) async {
  bool append = ref.watch(appendModeProvider);
  bool addFolder = ref.watch(addFolderProvider);
  if (append) {
    final files = ref.watch(fileListProvider);
    if (files.any((e) => e.filePath == filePath)) return;
  }

  bool isFile = FileSystemEntity.isFileSync(filePath);
  FunctionMode mode = ref.watch(currentModeProvider);
  bool isViewMode = ref.watch(viewModeProvider);

  // 如果不是添加文件夹并且添加的不是文件且不是整理模式
  if (!addFolder && (!isFile && mode != FunctionMode.organize)) {
    final list = getAllFile(filePath);
    toFormatFile(ref, list);
    return;
  }

  ref.read(countProvider.notifier).update(count);

  FileInfo fileInfo = await generateFileInfo(ref, filePath);
  if (isViewMode && fileInfo.type != FileClassify.image) return;
  ref.read(fileListProvider.notifier).add(fileInfo);

  if (mode == FunctionMode.organize) {
    TextEditingController controller = ref.watch(targetControllerProvider);
    if (controller.text.isEmpty) {
      controller.text = isFile ? fileInfo.parent : filePath;
    }
  }

  if (ref.watch(cSVDataProvider).isNotEmpty) {
    newFeatureRename(ref);
  } else {
    updateName(ref);
    updateExtension(ref);
  }
}

List<String> getAllFile(String folder) {
  Directory directory = Directory(folder);
  List<String> children = [];
  List<FileSystemEntity> files = directory.listSync(recursive: true);
  for (var file in files) {
    if (FileSystemEntity.isFileSync(file.path)) {
      String extension = path.extension(file.path);
      extension = extension == '' ? extension : extension.substring(1);
      if (!filter.contains(extension)) children.add(file.path);
    }
  }
  return children;
}

Future<FileInfo> generateFileInfo(WidgetRef ref, String filePath) async {
  String id = nanoid(10);
  String name = path.basenameWithoutExtension(filePath);
  String extension = 'dir';
  String parent = path.dirname(filePath);
  DateTime? exifDate;
  DateTime createDate = File(filePath).statSync().changed;
  DateTime modifyDate = File(filePath).statSync().modified;
  extension = getFileExtension(filePath);
  if (image.contains(extension)) exifDate = await getExifDate(filePath);
  FileClassify type = ref.read(getFileClassifyProvider(extension));
  FileInfo fileInfo = FileInfo(
    id: id,
    name: name,
    newName: name,
    parent: parent,
    filePath: filePath,
    extension: extension,
    newExtension: extension,
    beforePath: filePath,
    createdDate: createDate,
    modifiedDate: modifyDate,
    exifDate: exifDate,
    type: type,
    checked: true,
  );
  return fileInfo;
}

Future<DateTime?> getExifDate(String filePath) async {
  final fileBytes = File(filePath).readAsBytesSync();
  final data = await readExifFromBytes(fileBytes);
  if (!data.containsKey('Image DateTime')) return null;
  String? dateTime = data['Image DateTime'].toString();
  if (dateTime == '') return null;
  Log.i('$filePath 拍摄日期: ${formatExifDate(dateTime)}');
  return formatExifDate(dateTime);
}

void selectAll(WidgetRef ref) {
  ref.read(selectAllProvider.notifier).update();
  updateName(ref);
  updateExtension(ref);
}

void toggleSortType(WidgetRef ref) {
  int index = SortType.values.indexOf(ref.read(fileSortTypeProvider));
  ++index;
  if (index > SortType.values.length - 1) index = 0;
  SortType type = SortType.values[index];
  ref.read(fileSortTypeProvider.notifier).update(type);
  updateName(ref);
  updateExtension(ref);
}

void deleteAll(WidgetRef ref) {
  ref.read(fileListProvider.notifier).clear();
  ref.read(countProvider.notifier).clear();
  ref.read(totalProvider.notifier).clear();
  ref.read(costProvider.notifier).clear();
}

void autoInput(WidgetRef ref, String fileName) {
  bool dateRename = ref.watch(dateRenameProvider);
  if (dateRename) ref.read(dateRenameProvider.notifier).update();
  bool modifyNotEmpty = ref.watch(modifyClearProvider);
  FunctionMode mode = ref.watch(currentModeProvider);
  if (modifyNotEmpty && mode == FunctionMode.reserve) {
    ref.watch(modifyControllerProvider).text = '';
  }
  ref.watch(matchControllerProvider).text = fileName;
  updateName(ref);
}

void toggleCheck(WidgetRef ref, String id) {
  ref.read(fileListProvider.notifier).check(id);
  updateName(ref);
  updateExtension(ref);
}

void deleteOne(WidgetRef ref, String id) {
  ref.read(fileListProvider.notifier).remove(id);
  updateName(ref);
}
