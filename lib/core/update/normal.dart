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
  final String extension = ref.read(extensionControllerProvider).text;
  final bool isDate = ref.read(isDateRenameProvider);
  final bool isExtension = ref.read(isModifyExtensionProvider);
  final bool caseFile = ref.read(isCaseFileProvider);
  final bool caseExtension = ref.read(isCaseExtProvider);
  Map<String, dynamic> classifyMap = {};
  final List<FileInfo> files = ref.watch(sortListProvider);
  final FileList fileProvider = ref.read(fileListProvider.notifier);
  int index = 0;
  for (FileInfo file in files) {
    if (!file.checked) {
      fileProvider.updateNewName(file.id, file.name);
      fileProvider.updateNewExtension(file.id, file.extension);
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
      caseExtension,
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
    fileProvider.updateNewExtension(
      file.id,
      isExtension ? extension : file.extension,
    );
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
      (_, index) = calculateIndex(classifyMap, [date, file.extension], file);
    }
  } else {
    if (caseFile && !caseExt) {
      (_, index) = calculateIndex(classifyMap, [file.type.label], file);
    }
    if (caseExt) {
      (_, index) = calculateIndex(classifyMap, [file.extension], file);
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
    final String key = keys[i];
    final bool isLastKey = i == keys.length - 1;
    if (isLastKey) {
      List<FileInfo> files;
      if (currentLevel[key] is Map<String, dynamic>) {
        files = currentLevel[key]['_files'] as List<FileInfo>;
      } else {
        files = currentLevel[key] as List<FileInfo>? ?? <FileInfo>[];
        currentLevel[key] = files;
      }
      final int index = files.indexOf(file);
      if (index == -1) {
        files.add(file);
        return (classifyMap, files.length - 1);
      }
      return (classifyMap, index);
    } else {
      if (currentLevel.containsKey(key) &&
          currentLevel[key] is List<FileInfo>) {
        final List<FileInfo> existingFiles =
            currentLevel[key] as List<FileInfo>;
        currentLevel[key] = {'_files': existingFiles};
      }
      if (!currentLevel.containsKey(key)) {
        currentLevel[key] = <String, dynamic>{};
      }
      currentLevel = currentLevel[key] as Map<String, dynamic>;
    }
  }
  return (classifyMap, -1);
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
