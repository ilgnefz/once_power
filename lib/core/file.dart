import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:charset/charset.dart';
import 'package:exif/exif.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/notification_info.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/common/notification.dart';
import 'package:once_power/widgets/content_bar/type_detail_panel.dart';
import 'package:path/path.dart' as path;
import 'package:pinyin/pinyin.dart';

import 'core.dart';

// 处理通过拖动添加的文件或文件夹
Future<void> formatPath(WidgetRef ref, List<String> paths) async {
  List<String> files = [];
  List<String> folders = [];
  for (String p in paths) {
    bool isFile = await FileSystemEntity.isFile(p);
    if (isFile) files.add(p);
    if (!isFile) folders.add(p);
  }
  if (folders.isNotEmpty) formatFolder(ref, folders);
  if (files.isNotEmpty) addFileInfo(ref, files);
}

// 处理通过按钮添加的文件
Future<void> formatXFile(WidgetRef ref, List<XFile> files) async {
  final List<String> paths = files.map((e) => e.path).toList();
  addFileInfo(ref, paths);
}

// 处理传入来的文件夹，如果是添加文件夹就直接格式文件夹，不是就获取文件夹中的子文件
Future<void> formatFolder(WidgetRef ref, List<String?> folders) async {
  bool addFolder = ref.watch(addFolderProvider);
  bool addSubfolder = ref.watch(addSubfolderProvider);
  FunctionMode mode = ref.watch(currentModeProvider);
  List<String> list = [];
  for (String? folder in folders) {
    if (addFolder && !addSubfolder || mode.isOrganize) list.add(folder!);
    if (addFolder && addSubfolder && !mode.isOrganize) {
      list.addAll([folder!, ...getAllPath(folder, true)]);
    }
    if (!addFolder && !mode.isOrganize) list.addAll(getAllPath(folder!));
  }
  addFileInfo(ref, list);
}

Future<void> addFileInfo(WidgetRef ref, List<String> list) async {
  bool isViewMode = ref.watch(viewModeProvider);
  bool isOrganize = ref.watch(currentModeProvider).isOrganize;
  bool append = ref.watch(appendModeProvider);
  if (!append) ref.read(fileListProvider.notifier).clear();
  int count = 0;
  ref.read(totalProvider.notifier).update(list.length);
  int startTime = DateTime.now().microsecondsSinceEpoch;
  for (String filePath in list) {
    String ext = getFileExtension(filePath);
    bool isFile = ext != 'dir';
    bool noImageVideo = !image.contains(ext) && !video.contains(ext);
    if (isViewMode && !isOrganize && noImageVideo) continue;
    ref.read(countProvider.notifier).update(++count);
    bool exist = ref.watch(fileListProvider).any((e) => e.filePath == filePath);
    if (exist) continue;
    FileInfo fileInfo = await generateFileInfo(ref, filePath, isFile);
    ref.read(fileListProvider.notifier).add(fileInfo);
    await Future.delayed(const Duration(microseconds: 1));
  }
  if (isViewMode && !isOrganize) {
    int removeCount = list.length - count;
    if (removeCount > 0) {
      NotificationType type = SuccessNotification(
          S.current.viewMode, S.current.removeNonImage(removeCount));
      NotificationMessage.show(type, 3);
    }
  }
  int endTime = DateTime.now().microsecondsSinceEpoch;
  double cost = (endTime - startTime) / 1000000;
  ref.read(costProvider.notifier).update(cost);
  updateName(ref);
  updateExtension(ref);
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

Future<FileInfo> generateFileInfo(
    WidgetRef ref, String filePath, bool isFile) async {
  String id = nanoid(10);
  String name = isFile
      ? path.basenameWithoutExtension(filePath)
      : path.basename(filePath);
  String phonetic = isChinese(name) ? PinyinHelper.getPinyinE(name) : name;
  String parent = path.dirname(filePath);
  DateTime? exifDate;
  DateTime createDate = File(filePath).statSync().changed;
  DateTime modifyDate = File(filePath).statSync().modified;
  String extension = getFileExtension(filePath);
  if (image.contains(extension)) exifDate = await getExifDate(filePath);
  FileClassify type = getFileClassify(extension);
  return FileInfo(
    id: id,
    name: name,
    phonetic: phonetic,
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
}

Future<DateTime?> getExifDate(String filePath) async {
  final Uint8List fileBytes = File(filePath).readAsBytesSync();
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

void showAllType(BuildContext context, int type, [bool needPop = false]) async {
  if (needPop) Navigator.of(context).pop();
  await showDialog(
    context: context,
    builder: (BuildContext context) => TypeDetailPanel(type),
  );
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

bool isCheck(WidgetRef ref, FileClassify classify) {
  if (classify == FileClassify.audio) return ref.watch(selectAudioProvider);
  if (classify == FileClassify.other) return ref.watch(selectOtherProvider);
  if (classify == FileClassify.image) return ref.watch(selectImageProvider);
  if (classify == FileClassify.doc) return ref.watch(selectTextProvider);
  if (classify == FileClassify.video) return ref.watch(selectVideoProvider);
  if (classify == FileClassify.zip) return ref.watch(selectZipProvider);
  return ref.watch(selectFolderProvider);
}

Future<void> createLog(
    String filePath, String fileName, List<String> logs) async {
  final String time = formatDateTime(DateTime.now()).substring(0, 14);
  String folder = filePath == ''
      ? path.join(path.dirname(Platform.resolvedExecutable), 'logs')
      : filePath;
  Directory dir = Directory(folder);
  if (!dir.existsSync()) await dir.create();
  final File logFile = File(path.join(folder, '$fileName-$time.oplog'));
  String content = logs.join('\n');
  debugPrint('已成功创建日志文件:${logFile.path}');
  logFile.writeAsStringSync(content, mode: FileMode.write);
}

void tempSaveLog(WidgetRef ref, String oldPath, String newPath) {
  String content = '${DateTime.now()}: 【$oldPath】===>【$newPath】';
  ref.read(operateLogListProvider.notifier).add(content);
  ref.watch(operateLogListProvider);
}

void tempSaveDeleteLog(WidgetRef ref, String filePath) {
  String content = S.current.deleteInfo(filePath);
  ref.read(operateLogListProvider.notifier).add(content);
  ref.watch(operateLogListProvider);
}

Future<List<EasyRenameInfo>> decodeOPLogData(XFile file) async {
  String content = await file.readAsString();
  List<String> lines = content.split('\n');
  return lines.map((line) {
    final List<String> parts = line.split('===>');
    final String before =
        parts[0].split(':').last.trim().replaceAll(RegExp(r'【|】'), '');
    final String after = parts[1].trim().replaceAll(RegExp(r'【|】'), '');
    final String beforeWithoutExtension = before.split('.').first;
    final String afterWithoutExtension = after.split('.').first;
    return EasyRenameInfo(
        nameA: afterWithoutExtension, nameB: beforeWithoutExtension);
  }).toList();
}

Future<List<EasyRenameInfo>> decodeCSVData(XFile file) async {
  // NotificationInfo? errInfo;
  final Uint8List bytes = await file.readAsBytes();
  String content = '';
  try {
    content = utf8.decode(bytes);
  } catch (e) {
    try {
      content = gbk.decode(bytes);
    } catch (e) {
      Log.e('无法解析的编码格式：$e');
      // errInfo = NotificationInfo(file: file.path, message: '${S.current.decodeCSVError}: $e');
      NotificationMessage.show(
          ErrorNotification(S.current.decodeCSVError, e.toString()));
    }
  }
  List<String> splitList = content.trim().split('\n');
  List<EasyRenameInfo> list = [];
  for (String value in splitList) {
    List<String> temp = value.split(',').map((e) => e.trim()).toList();
    list.add(EasyRenameInfo(nameA: temp[0], nameB: temp[1]));
  }
  return list;
  // return list.where((e) => e.nameA != '' || e.nameB != '').toList();
}

String createClassifyFolder(FileInfo file, String parentFolderPath) {
  bool useTime = StorageUtil.getBool(AppKeys.isUseTimeClassification) ?? false;
  String folderName = useTime
      ? formatDateTime(file.modifiedDate).substring(0, 8)
      : file.type.value;
  String folderPath = path.join(parentFolderPath, folderName);
  if (!Directory(folderPath).existsSync()) {
    Directory(folderPath).createSync();
  }
  return folderPath;
}

List<FileInfo> splitSortList(List<FileInfo> fileList, bool reverse) {
  List<FileInfo> chineseList = [];
  List<FileInfo> otherList = [];
  for (FileInfo e in fileList) {
    if (isChinese(e.name)) {
      chineseList.add(e);
    } else {
      otherList.add(e);
    }
  }
  if (reverse) {
    chineseList.sort((a, b) => b.phonetic.compareTo(a.phonetic));
    otherList.sort((a, b) => b.name.compareTo(a.name));
    return [...chineseList, ...otherList];
  }
  chineseList.sort((a, b) => a.phonetic.compareTo(b.phonetic));
  otherList.sort((a, b) => a.name.compareTo(b.name));
  return [...otherList, ...chineseList];
}

void filterFile(BuildContext context, WidgetRef ref) {
  bool selected = ref.watch(viewModeProvider);
  bool isOrganize = ref.watch(currentModeProvider).isOrganize;
  if (selected && !isOrganize) {
    final FileList provider = ref.read(fileListProvider.notifier);
    final int before = ref.watch(fileListProvider).length;
    provider.removeOtherClassify([FileClassify.image, FileClassify.video]);
    final int after = ref.watch(fileListProvider).length;
    if (before > after) {
      int removeCount = before - after;
      NotificationType type = SuccessNotification(
          S.of(context).viewMode, S.of(context).removeNonImage(removeCount));
      NotificationMessage.show(type, 3);
    }
  }
}
