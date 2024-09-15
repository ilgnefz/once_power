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
  // 查看是否是附加模式
  bool append = ref.watch(appendModeProvider);
  // 是否添加文件夹
  bool addFolder = ref.watch(addFolderProvider);
  // 附加模式下查看新加的文件是否已经存在
  if (append) {
    final files = ref.watch(fileListProvider);
    if (files.any((e) => e.filePath == filePath)) return;
  }

  // 查看当前文件是不是文件
  bool isFile = FileSystemEntity.isFileSync(filePath);
  // 查看当前菜单模式
  FunctionMode mode = ref.watch(currentModeProvider);
  // 查看是不是视图模式
  bool isViewMode = ref.watch(viewModeProvider);

  // 如果没有勾选添加文件夹，并且传入的路径是一个文件夹，并且不是整理模式
  // 获取当前路径下的所有子文件
  if (!addFolder && (!isFile && mode != FunctionMode.organize)) {
    final list = getAllFile(filePath);
    toFormatFile(ref, list);
    return;
  }

  // 查看是否添加子文件夹
  bool addSubfolder = ref.watch(addSubfolderProvider);

  // 如果勾选了添加文件夹，并且传入的是文件夹并还勾选了添加子文件夹
  // 获取文件夹下的所有子文件夹
  if (addFolder && !isFile && addSubfolder && mode != FunctionMode.organize) {
    //   获取文件夹下的所有子文件夹
    final list = getAllFile(filePath, true);
    if (list.isNotEmpty) toFormatFile(ref, list);
  }

  // 更新 count 的值
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

List<String> getAllFile(String folder, [bool addChild = false]) {
  Directory directory = Directory(folder);
  List<String> children = [];
  List<FileSystemEntity> files = directory.listSync(recursive: !addChild);
  for (var file in files) {
    if (FileSystemEntity.isFileSync(file.path) && !addChild) {
      String extension = path.extension(file.path);
      extension = extension == '' ? extension : extension.substring(1);
      if (!filter.contains(extension)) children.add(file.path);
    }
    if (addChild && FileSystemEntity.isDirectorySync(file.path)) {
      children.add(file.path);
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
