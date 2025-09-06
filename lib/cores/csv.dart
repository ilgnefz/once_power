import 'dart:convert';
import 'dart:typed_data';

import 'package:charset/charset.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/models/csv.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/utils/info.dart';

void csvDataRename(WidgetRef ref) {
  List<FileInfo> list = ref.watch(fileListProvider);
  List<CsvRenameInfo> csvList = ref.watch(cSVDataProvider);
  bool isA = ref.watch(cSVNameColumnProvider) == 'A';
  CsvRenameInfo badInfo = CsvRenameInfo(nameA: '', nameB: '');
  for (FileInfo file in list) {
    if (!file.checked) {
      ref.read(fileListProvider.notifier).updateNewName(file.id, file.name);
      ref.read(fileListProvider.notifier).updateNewExt(file.id, file.ext);
      continue;
    }
    bool isDeleteExtension = ref.watch(deleteExtensionProvider);
    String extension = isDeleteExtension ? '' : file.ext;
    bool isMatchExtension = ref.watch(matchExtensionProvider);
    String name = file.name;
    if (isMatchExtension) name = getFullName(name, extension);
    final (key, value) = isA
        ? (name, (CsvRenameInfo e) => e.nameB)
        : (name, (CsvRenameInfo e) => e.nameA);

    CsvRenameInfo matching = csvList.firstWhere(
      (CsvRenameInfo e) => (isA ? e.nameA : e.nameB) == key,
      orElse: () => badInfo,
    );

    if (matching != badInfo) name = value(matching);
    if (isMatchExtension) {
      extension = name.contains('.') ? name.split('.').last : '';
      name = name.split('.').first;
    }
    ref.read(fileListProvider.notifier).updateNewName(file.id, name);
    ref.read(fileListProvider.notifier).updateNewExt(file.id, extension);
  }
}

Future<List<CsvRenameInfo>> decodeOPLogData(XFile file) async {
  String content = await file.readAsString();
  List<String> lines = content.split('\n');
  return lines.map((line) {
    final List<String> parts = line.split('===>');
    final String before = parts[0]
        .split(':')
        .last
        .trim()
        .replaceAll(RegExp(r'【|】'), '');
    final String after = parts[1].trim().replaceAll(RegExp(r'【|】'), '');
    final String beforeWithoutExtension = before.split('.').first;
    final String afterWithoutExtension = after.split('.').first;
    return CsvRenameInfo(
      nameA: afterWithoutExtension,
      nameB: beforeWithoutExtension,
    );
  }).toList();
}

Future<List<CsvRenameInfo>> decodeCSVData(XFile file) async {
  final Uint8List bytes = await file.readAsBytes();
  String content = '';
  try {
    content = utf8.decode(bytes);
  } catch (e) {
    try {
      content = gbk.decode(bytes);
    } catch (e) {
      debugPrint('无法解析的编码格式：$e');
      showCSVDecodeError1Notification(e.toString());
    }
  }
  List<String> splitList = content.trim().split('\n');
  bool isLegal = splitList.every((e) => e.split(',').length == 2);
  if (!isLegal) {
    showCSVDecodeError2Notification();
    return [];
  }
  List<CsvRenameInfo> list = [];
  for (String value in splitList) {
    List<String> temp = value.split(',').map((e) => e.trim()).toList();
    list.add(CsvRenameInfo(nameA: temp[0], nameB: temp[1]));
  }
  return list;
}
