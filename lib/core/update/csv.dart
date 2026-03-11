import 'dart:convert';

import 'package:charset/charset.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/csv.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/util/notification.dart';
import 'package:path/path.dart' as path;

void cSVUpdateName(WidgetRef ref) {
  List<FileInfo> list = ref.watch(fileListProvider);
  List<CSVRenameInfo> csvList = ref.watch(cSVDataProvider);
  bool isA = ref.watch(cSVNameColumnProvider) == 'A';
  CSVRenameInfo badInfo = CSVRenameInfo(nameA: '', nameB: '');
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
        ? (name, (CSVRenameInfo e) => e.nameB)
        : (name, (CSVRenameInfo e) => e.nameA);

    CSVRenameInfo matching = csvList.firstWhere(
      (CSVRenameInfo e) => (isA ? e.nameA : e.nameB) == key,
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

Future<List<CSVRenameInfo>> decodeLogData(XFile file) async {
  String content = await file.readAsString();
  List<String> lines = content.split('\n');
  List<CSVRenameInfo> list = [];
  for (String line in lines) {
    if (!line.contains(' <=====> ')) continue;
    final List<String> parts = line.split(' <=====> ');
    final String before = path.basename(parts.first);
    final String after = path.basename(parts.last);
    list.add(CSVRenameInfo(nameA: before, nameB: after));
  }
  if (list.isEmpty) showLogDecodeErrorNotification();
  return list;
}

Future<List<CSVRenameInfo>> decodeCSVData(XFile file) async {
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
  List<CSVRenameInfo> list = [];
  for (String value in splitList) {
    List<String> temp = value.split(',').map((e) => e.trim()).toList();
    list.add(CSVRenameInfo(nameA: temp[0], nameB: temp[1]));
  }
  return list;
}
