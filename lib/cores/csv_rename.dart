import 'dart:convert';
import 'dart:typed_data';

import 'package:charset/charset.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/utils/log.dart';

void cSVDataRename(WidgetRef ref) {
  List<FileInfo> list = ref.watch(fileListProvider);
  List<CsvRenameInfo> csvList = ref.watch(cSVDataProvider);
  bool isA = ref.watch(cSVNameColumnProvider) == 'A';
  CsvRenameInfo badInfo = CsvRenameInfo(nameA: '', nameB: '');
  for (FileInfo file in list) {
    if (!file.checked) {
      ref.read(fileListProvider.notifier).updateName(file.id, file.name);
      continue;
    }
    bool isDeleteExtension = ref.watch(isDeleteExtensionProvider);
    bool isMatchExtension = ref.watch(isMatchExtensionProvider);
    if (isDeleteExtension) {
      ref.read(fileListProvider.notifier).updateExtension(file.id, '');
    }
    String name = file.name;
    if (isMatchExtension) name = getNameWithExt(name, file.extension);
    final (key, value) =
        isA ? (name, (CsvRenameInfo e) => e.nameB) : (name, (e) => e.nameA);

    final matching = csvList.firstWhere((e) => (isA ? e.nameA : e.nameB) == key,
        orElse: () => badInfo);

    ref
        .read(fileListProvider.notifier)
        .updateName(file.id, matching != badInfo ? value(matching) : file.name);
  }
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
      Log.e('无法解析的编码格式：$e');
      NotificationInfo(
        type: NotificationType.error,
        title: S.current.decodeCSVError,
        message: e.toString(),
      ).show();
    }
  }
  List<String> splitList = content.trim().split('\n');
  bool isLegal = splitList.every((e) => e.split(',').length == 2);
  if (!isLegal) {
    NotificationInfo(
      type: NotificationType.error,
      title: S.current.decodeCSVError,
      message: S.current.decodeCSVError2,
      time: 5,
    ).show();
    return [];
  }
  List<CsvRenameInfo> list = [];
  for (String value in splitList) {
    List<String> temp = value.split(',').map((e) => e.trim()).toList();
    list.add(CsvRenameInfo(nameA: temp[0], nameB: temp[1]));
  }
  return list;
}

Future<List<CsvRenameInfo>> decodeOPLogData(XFile file) async {
  String content = await file.readAsString();
  List<String> lines = content.split('\n');
  return lines.map((line) {
    final List<String> parts = line.split('===>');
    final String before =
        parts[0].split(':').last.trim().replaceAll(RegExp(r'【|】'), '');
    final String after = parts[1].trim().replaceAll(RegExp(r'【|】'), '');
    final String beforeWithoutExtension = before.split('.').first;
    final String afterWithoutExtension = after.split('.').first;
    return CsvRenameInfo(
        nameA: afterWithoutExtension, nameB: beforeWithoutExtension);
  }).toList();
}
