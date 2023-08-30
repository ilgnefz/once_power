import 'dart:io';

import 'package:exif/exif.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/utils.dart';
import 'package:path/path.dart' as path;

Future<DateTime?> getExifDate(String filePath) async {
  final fileBytes = File(filePath).readAsBytesSync();
  final data = await readExifFromBytes(fileBytes);
  if (!data.containsKey('Image DateTime')) return null;
  String? dateTime = data['Image DateTime'].toString();
  if (dateTime == '') return null;
  debugPrint('$filePath拍摄日期: ${exifDateFormat(dateTime)}');
  return exifDateFormat(dateTime);
}

void xFileFormat(WidgetRef ref, List<XFile> files) async {
  bool append = ref.watch(appendModeProvider);
  if (!append) ref.read(fileListProvider.notifier).clear();
  // ref.read(totalProvider.notifier).update(files.length);
  for (var file in files) {
    fileFormat(ref, file.path);
  }
}

void fileFormat(WidgetRef ref, String filePath) async {
  bool append = ref.watch(appendModeProvider);
  bool addFolder = ref.watch(addFolderProvider);
  // if (!append) ref.read(countProvider.notifier).clear();
  if (append) {
    final files = ref.watch(fileListProvider);
    if (files.any((e) => e.filePath == filePath)) return;
  }

  bool isFile = FileSystemEntity.isFileSync(filePath);

  if (!addFolder && !isFile) {
    final list = ref.read(getAllFileProvider(filePath));
    // ref.read(totalProvider.notifier).update(list.length);
    for (var file in list) {
      fileFormat(ref, file);
    }
    return;
  }
  await Future.delayed(const Duration(microseconds: 1));
  // ref.read(countProvider.notifier).increment();

  String id = nanoid(10);
  String name = path.basename(filePath);
  String extension = 'dir';
  DateTime? exifDate;
  DateTime createDate = File(filePath).statSync().changed;
  DateTime modifyDate = File(filePath).statSync().modified;
  if (isFile) {
    extension = path.extension(filePath);
    // 有可能文件没有扩展名
    if (extension != '') {
      name = name.split(extension).first;
      extension = extension.substring(1);
    }
    // 如果是图片就获取 exif 中的拍摄日期
    if (image.contains(extension)) {
      exifDate = await getExifDate(filePath);
    }
  }
  FileClassify type = ref.read(getFileClassifyProvider(extension));
  RenameFile renameFile = RenameFile(
    id: id,
    name: name,
    newName: name,
    parent: path.dirname(filePath),
    filePath: filePath,
    extension: extension,
    newExtension: extension,
    createDate: createDate,
    modifyDate: modifyDate,
    exifDate: exifDate,
    type: type,
    checked: true,
  );
  ref.read(fileListProvider.notifier).add(renameFile);
  updateName(ref);
  updateExtension(ref);
}
