import 'dart:io' show File;

import 'package:charset/charset.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/utils/info.dart';
import 'package:path/path.dart' as path;

import 'list.dart';
import 'notification.dart';
import 'replace.dart';
import 'reserve.dart';

void normalUpdateName(WidgetRef ref, bool isReserve) {
  final String match = ref.watch(matchControllerProvider).text;
  final String modify = ref.watch(modifyControllerProvider).text;
  final bool isLen = ref.watch(isInputLenProvider);
  final bool caseSen = ref.watch(isCaseSensitiveProvider);
  final bool isDate = ref.watch(isDateRenameProvider);
  final bool modifyExt = ref.watch(isModifyExtProvider);
  final String ext = ref.watch(extensionControllerProvider).text;
  final bool caseFile = ref.watch(caseFileProvider);
  final bool caseExt = ref.watch(caseExtProvider);
  Map<String, dynamic> classifyMap = {};
  final List<FileInfo> currentFiles = ref.read(sortListProvider);
  final FileList fileListNotifier = ref.read(fileListProvider.notifier);
  int index = 0;
  for (FileInfo file in currentFiles) {
    if (!file.checked) {
      fileListNotifier.updateNewName(file.id, file.name);
      fileListNotifier.updateNewExt(file.id, file.ext);
      continue;
    }
    String date = dateName(ref, file);
    String name = isDate
        ? date
        : isReserve
            ? reserveName(ref, file.name, match, modify, isLen, caseSen)
            : replaceName(ref, file.name, match, modify, isLen, caseSen);
    index = getRealIndex(
      date,
      caseFile,
      caseExt,
      isDate,
      index,
      file,
      classifyMap,
    );
    final String prefix = prefixValue(ref, index);
    final String suffix = suffixValue(ref, index);
    name = prefix + name + suffix;
    fileListNotifier.updateNewName(file.id, name);
    fileListNotifier.updateNewExt(file.id, modifyExt ? ext : file.ext);
    index++;
  }
}

String dateName(WidgetRef ref, FileInfo file) {
  int dateLen = ref.watch(dateLenProvider);
  DateType type = ref.watch(currentDateTypeProvider);
  return getDateName(getDate(type, file), dateLen);
}

int getRealIndex(
  String date,
  bool caseFile,
  bool caseExt,
  bool dateRename,
  int index,
  FileInfo file,
  Map<String, dynamic> classifyMap,
) {
  if (dateRename) {
    (classifyMap, index) = calculateIndex(classifyMap, [date], file);
    if (caseFile && !caseExt) {
      (_, index) = calculateIndex(classifyMap, [date, file.type.label], file);
    }
    if (caseExt) {
      (_, index) = calculateIndex(classifyMap, [date, file.ext], file);
    }
  } else {
    if (caseFile && !caseExt) {
      (_, index) = calculateIndex(classifyMap, [file.type.label], file);
    }
    if (caseExt) {
      (_, index) = calculateIndex(classifyMap, [file.ext], file);
    }
  }
  return index;
}

Future<UploadMarkInfo?> readUploadFile(String filePath) async {
  String fileName = path.basename(filePath);
  String content = '';
  final File file = File(filePath);
  try {
    content = await file.readAsString();
  } catch (e) {
    try {
      final bytes = await file.readAsBytes();
      content = gbk.decode(bytes);
    } catch (gbError) {
      showTxtDecodeNotification(gbError.toString());
      return null;
    }
  }
  return UploadMarkInfo(name: fileName, content: content);
}

String prefixValue(WidgetRef ref, int index) {
  String prefix = inputPrefix(ref, index);
  final int len = ref.watch(prefixSerialLenProvider);
  final int start = ref.watch(prefixSerialStartProvider);
  final String serial = formatNum(start + index, len);
  final bool swap = ref.watch(isSwapPrefixProvider);
  return swap ? serial + prefix : prefix + serial;
}

String inputPrefix(WidgetRef ref, int index) {
  String prefix = ref.watch(prefixControllerProvider).text;
  final UploadMarkInfo? info = ref.watch(prefixUploadMarkProvider);
  List<String> prefixList = info == null ? [] : strToList(info.content);
  if (prefixList.isEmpty) return prefix;
  final bool cycle = ref.watch(isCyclePrefixProvider);
  if (cycle) return prefixList[index % prefixList.length] + prefix;
  return index >= prefixList.length ? prefix : prefixList[index] + prefix;
}

String suffixValue(WidgetRef ref, int index) {
  String suffix = inputSuffix(ref, index);
  final int len = ref.watch(suffixSerialLenProvider);
  final int start = ref.watch(suffixSerialStartProvider);
  final String serial = formatNum(start + index, len);
  final bool swap = ref.watch(isSwapSuffixProvider);
  return swap ? serial + suffix : suffix + serial;
}

String inputSuffix(WidgetRef ref, int index) {
  final String suffix = ref.watch(suffixControllerProvider).text;
  final UploadMarkInfo? info = ref.watch(suffixUploadMarkProvider);
  List<String> suffixList = info == null ? [] : strToList(info.content);
  if (suffixList.isEmpty) return suffix;
  final bool cycle = ref.watch(isCycleSuffixProvider);
  if (cycle) return suffixList[index % suffixList.length] + suffix;
  return index >= suffixList.length ? suffix : suffixList[index] + suffix;
}
