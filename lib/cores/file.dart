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
  await addFileInfo(ref, files);
}

Future<List<String>> handleFolder(WidgetRef ref, List<String?> folders) async {
  bool addFolder = ref.watch(isAddFolderProvider);
  bool addSubfolder = ref.watch(isAddSubfolderProvider);
  List<String> paths = [];
  for (String? folder in folders) {
    if (addFolder && !addSubfolder) paths.add(folder!);
    if (addFolder && addSubfolder) {
      paths.addAll([folder!, ...getAllPath(folder, true)]);
    }
    if (!addFolder) paths.addAll(getAllPath(folder!));
  }
  return paths;
}

List<String> getAllPath(String folder, [bool addSubfolder = false]) {
  Directory directory = Directory(folder);
  List<String> children = [];
  List<FileSystemEntity> files = directory.listSync(recursive: true);
  for (FileSystemEntity file in files) {
    if (FileSystemEntity.isFileSync(file.path) && !addSubfolder) {
      String extension = path.extension(file.path);
      extension = extension == '' ? extension : extension.substring(1);
      if (!filter.contains(extension)) children.add(file.path);
    }
    if (FileSystemEntity.isDirectorySync(file.path) && addSubfolder) {
      children.add(file.path);
    }
  }
  return children;
}

Future<void> addFileInfo(WidgetRef ref, List<String> paths) async {
  bool isAppend = ref.watch(isAppendModeProvider);
  if (!isAppend) ref.read(fileListProvider.notifier).clear();
  int count = 0;
  ref.read(totalProvider.notifier).update(paths.length);
  DateTime startTime = DateTime.now();
  for (String p in paths) {
    if (isViewNoOrganize(ref) && !isImgVideo(p)) continue;
    if (isExist(ref, p)) continue;
    FileInfo fileInfo = await generateFileInfo(ref, p);
    // Log.i(jsonEncode(fileInfo.toJson()));
    ref.read(fileListProvider.notifier).add(fileInfo);
    ref.read(countProvider.notifier).update(++count);
    await Future.delayed(const Duration(microseconds: 1));
  }
  if (isViewNoOrganize(ref)) showFilterNotification(paths.length - count);
  double cost = DateTime.now().difference(startTime).inMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  updateName(ref);
}

Future<FileInfo> generateFileInfo(WidgetRef ref, String filePath) async {
  String id = nanoid(10);
  String name = getPathName(filePath);
  String phonetic = isChinese(name) ? PinyinHelper.getPinyinE(name) : name;
  String parent = path.dirname(filePath);
  DateTime? exifDate;
  DateTime createdDate = File(filePath).statSync().changed;
  DateTime modifyDate = File(filePath).statSync().modified;
  String extension = getExtension(filePath);
  if (image.contains(extension)) exifDate = await getExifDate(filePath);
  FileClassify type = getFileClassify(extension);
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
