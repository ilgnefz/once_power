import 'dart:io';

import 'package:charset/charset.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/model/normal.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/info.dart';
import 'package:path/path.dart' as path;

import 'replace.dart';
import 'reserve.dart';

void normalUpdateName(WidgetRef ref, [bool? replace]) {
  final bool isReplace = replace ?? ref.read(currentModeProvider).isReplace;
  final NormalInfo info = NormalInfo(
    match: ref.read(matchControllerProvider).text,
    modify: ref.read(modifyControllerProvider).text,
    isLen: ref.read(isInputLenProvider),
    caseSen: ref.read(isCaseSensitiveProvider),
  );
  // final String match = ;
  // final String modify = ;
  final String ext = ref.read(extensionControllerProvider).text;
  // final bool isLen = ;
  // final bool caseSen =;
  final bool isDate = ref.read(isDateRenameProvider);
  final bool isExt = ref.read(isModifyExtensionProvider);
  final bool caseFile = ref.read(isCaseFileProvider);
  final bool caseExt = ref.read(isCaseExtProvider);
  Map<String, dynamic> classifyMap = {};
  final List<FileInfo> files = ref.watch(sortListProvider);
  final FileList fileProvider = ref.read(fileListProvider.notifier);
  int index = 0;
  for (FileInfo file in files) {
    if (!file.checked) {
      fileProvider.updateNewName(file.id, file.name);
      fileProvider.updateNewExt(file.id, file.ext);
      continue;
    }
    String date = dateName(ref, file);
    String name = isDate
        ? date
        : isReplace
        ? replaceName(ref, file.name, info)
        : reserveName(ref, file.name, info);
    fileProvider.updateNewName(file.id, name);
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
    name = removeForbiddenCharacters(name);
    fileProvider.updateNewName(file.id, name);
    fileProvider.updateNewExt(file.id, isExt ? ext : file.ext);
    index++;
  }
}

String dateName(WidgetRef ref, FileInfo file) {
  int dateLen = ref.watch(dateDigitProvider);
  DateType type = ref.watch(currentDateTypeProvider);
  return getDateName(getDate(type, file)?.date, dateLen);
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

(Map<String, dynamic>, int) calculateIndex(
  Map<String, dynamic> classifyMap,
  List<String> keys,
  FileInfo file,
) {
  Map<String, dynamic> currentLevel = classifyMap;

  for (int i = 0; i < keys.length; i++) {
    final key = keys[i];
    final isLastKey = i == keys.length - 1;

    if (isLastKey) {
      if (currentLevel[key] is Map<String, dynamic>) {
        final files = currentLevel[key]['_files'] as List<FileInfo>;
        if (!files.contains(file)) files.add(file);
      } else {
        if (!currentLevel.containsKey(key)) currentLevel[key] = <FileInfo>[];
        final files = currentLevel[key] as List<FileInfo>;
        if (!files.contains(file)) files.add(file);
      }
    } else {
      if (currentLevel.containsKey(key) &&
          currentLevel[key] is List<FileInfo>) {
        final existingFiles = currentLevel[key] as List<FileInfo>;
        currentLevel[key] = {'_files': existingFiles};
      }

      if (!currentLevel.containsKey(key)) {
        currentLevel[key] = <String, dynamic>{};
      }
      currentLevel = currentLevel[key] as Map<String, dynamic>;
    }
  }

  final lastKey = keys.last;
  if (currentLevel[lastKey] is Map<String, dynamic>) {
    final files = currentLevel[lastKey]['_files'] as List<FileInfo>;
    return (classifyMap, files.indexOf(file));
  }
  final files = currentLevel[lastKey] as List<FileInfo>;
  return (classifyMap, files.indexOf(file));
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
      // showTxtDecodeNotification(gbError.toString());
      return null;
    }
  }
  return UploadMarkInfo(name: fileName, content: content);
}

String prefixValue(WidgetRef ref, int index) {
  String prefix = inputPrefix(ref, index);
  final int len = ref.read(prefixDigitProvider);
  final int start = ref.read(prefixStartProvider);
  final String serial = formatNum(start + index, len);
  final bool swap = ref.read(isSwapPrefixProvider);
  return swap ? serial + prefix : prefix + serial;
}

String inputPrefix(WidgetRef ref, int index) {
  String prefix = ref.watch(prefixControllerProvider).text;
  final UploadMarkInfo? info = ref.watch(prefixUploadMarkProvider);
  List<String> prefixList = info == null ? [] : stringToList(info.content);
  if (prefixList.isEmpty) return prefix;
  final bool cycle = ref.watch(isCyclePrefixProvider);
  if (cycle) return prefixList[index % prefixList.length] + prefix;
  return index >= prefixList.length ? prefix : prefixList[index] + prefix;
}

String suffixValue(WidgetRef ref, int index) {
  String suffix = inputSuffix(ref, index);
  final int len = ref.watch(suffixDigitProvider);
  final int start = ref.watch(suffixStartProvider);
  final String serial = formatNum(start + index, len);
  final bool swap = ref.watch(isSwapSuffixProvider);
  return swap ? serial + suffix : suffix + serial;
}

String inputSuffix(WidgetRef ref, int index) {
  final String suffix = ref.watch(suffixControllerProvider).text;
  final UploadMarkInfo? info = ref.watch(suffixUploadMarkProvider);
  List<String> suffixList = info == null ? [] : stringToList(info.content);
  if (suffixList.isEmpty) return suffix;
  final bool cycle = ref.watch(isCycleSuffixProvider);
  if (cycle) return suffixList[index % suffixList.length] + suffix;
  return index >= suffixList.length ? suffix : suffixList[index] + suffix;
}
