import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/core.dart';
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
import 'package:path/path.dart' as path;

void updateExtension(WidgetRef ref, [bool isUndo = false]) {
  List<FileInfo> files = ref.read(fileListProvider);
  String inputExt = ref.watch(extensionControllerProvider).text;
  bool isModifyExt = ref.watch(modifyExtensionProvider);
  for (FileInfo file in files) {
    String newExt = file.extension;
    if (!isUndo) {
      if (file.checked && !file.type.isFolder && isModifyExt) newExt = inputExt;
    }
    ref.read(fileListProvider.notifier).updateExtension(file.id, newExt);
  }
}

int dateRenameIndex(WidgetRef ref, DateFormatMap dfMap, FileInfo file) {
  bool caseClassify = ref.watch(caseClassifyProvider);
  bool caseExtension = ref.watch(caseExtensionProvider);
  int index = 0;
  String dateText = dateName(ref, file);
  if (caseClassify && !caseExtension) {
    String classify = getFileClassifyName(file.type);
    index = generateDFMapIndex(ref, dfMap, dateText, classify, file.name);
  }
  if (caseExtension) {
    String extension = file.extension;
    index = generateDFMapIndex(ref, dfMap, dateText, extension, file.name);
  }
  return index;
}

int generateDFMapIndex(
  WidgetRef ref,
  DateFormatMap dfMap,
  String dateText,
  String key,
  String value,
) {
  int index = 0;
  List<String> dateKeyList = dfMap.keys.toList();
  if (dateKeyList.contains(dateText)) {
    List<String> classifyList = dfMap[dateText]!.keys.toList();
    if (classifyList.contains(key)) {
      List<String>? fileNameList = dfMap[dateText]![key];
      index += fileNameList!.length;
      fileNameList.add(value);
    } else {
      dfMap[dateText]?.addAll({
        key: [value]
      });
    }
  } else {
    dfMap.addAll({
      dateText: {
        key: [value]
      }
    });
  }
  return index;
}

int actualIndex(
  WidgetRef ref,
  DateFormatMap dfMap,
  Map<String, List<String>> tempTypeMap,
  FileInfo file,
) {
  int index = 0;
  bool dateRename = ref.watch(dateRenameProvider);
  bool caseClassify = ref.watch(caseClassifyProvider);
  bool caseExtension = ref.watch(caseExtensionProvider);
  if (dateRename && !caseClassify && !caseExtension) {
    String dateText = dateName(ref, file);
    index = generateMapIndex(tempTypeMap, dateText, file.name);
  }
  if (dateRename && (caseClassify || caseExtension)) {
    dateRenameIndex(ref, dfMap, file);
  }
  if (caseClassify && !caseExtension) {
    String classify = file.type.value;
    index = generateMapIndex(tempTypeMap, classify, file.name);
  }
  if (caseExtension) {
    String extension = getFileExtension(file.filePath);
    index = generateMapIndex(tempTypeMap, extension, file.name);
  }
  return index;
}

int generateMapIndex(
  Map<String, List<String>> tempTypeMap,
  String key,
  String value,
) {
  int index = 0;
  if (tempTypeMap.keys.contains(key)) {
    tempTypeMap[key]?.add(value);
    index += tempTypeMap[key]!.length - 1;
  } else {
    tempTypeMap.addAll({
      key: [value]
    });
  }
  return index;
}

void updateName(WidgetRef ref) {
  if (ref.watch(cSVDataProvider).isNotEmpty) return cSVDataRename(ref);
  List<FileInfo> files = ref.read(sortListProvider);
  String prefixIndexText = ref.watch(prefixStartControllerProvider).text;
  int prefixIndex = getNum(prefixIndexText);
  String suffixIndexText = ref.watch(suffixStartControllerProvider).text;
  int suffixIndex = getNum(suffixIndexText);
  int fileIndex = 0;
  // 文件列表，用来存储日期和文件名
  DateFormatMap dfMap = {};
  Map<String, List<String>> tempTypeMap = {};
  bool dateRename = ref.watch(dateRenameProvider);
  bool caseClassify = ref.watch(caseClassifyProvider);
  bool caseExtension = ref.watch(caseExtensionProvider);
  for (FileInfo file in files) {
    if (file.checked) {
      int actualFileIndex = actualIndex(ref, dfMap, tempTypeMap, file);
      int actualPrefixIndex = prefixIndex + actualFileIndex;
      int actualSuffixIndex = suffixIndex + actualFileIndex;
      String newName = matchContent(
          ref, file, fileIndex, actualPrefixIndex, actualSuffixIndex);
      ref.read(fileListProvider.notifier).updateName(file.id, newName);
      fileIndex++;
      if (!dateRename && !caseClassify && !caseExtension) {
        prefixIndex++;
        suffixIndex++;
      }
    } else {
      ref.read(fileListProvider.notifier).updateName(file.id, file.name);
    }
  }
}

String matchContent(WidgetRef ref, FileInfo file, int fileIndex,
    int prefixIndex, int suffixIndex) {
  FunctionMode mode = ref.watch(currentModeProvider);
  bool isLength = ref.watch(inputLengthProvider);
  bool matchCase = ref.watch(matchCaseProvider);
  bool dateRename = ref.watch(dateRenameProvider);
  String? dateText = dateRename ? dateName(ref, file) : null;
  String matchText = ref.watch(matchControllerProvider).text;
  String modifyText = dateText ?? ref.watch(modifyControllerProvider).text;
  String name = file.name;

  if (mode.isReplace) {
    List<ReplaceType> replaceTypeList = ref.watch(currentReplaceTypeProvider);
    name = replaceName(
        replaceTypeList, matchText, modifyText, name, isLength, matchCase);
  }

  if (mode.isReserve) {
    List<ReserveType> typeList = ref.watch(currentReserveTypeProvider);
    name =
        reserveName(typeList, matchText, modifyText, name, isLength, matchCase);
  }

  name = prefixName(ref, fileIndex, prefixIndex) +
      name +
      suffixName(ref, fileIndex, suffixIndex);
  return name;
}

String dateName(WidgetRef ref, FileInfo file) {
  String date = formatDateTime(file.createdDate);
  String dateDigitText = ref.watch(dateLengthControllerProvider).text;
  int dateDigit = getNum(dateDigitText);
  DateType type = ref.watch(currentDateTypeProvider);
  if (type.isModifiedDate) date = formatDateTime(file.modifiedDate);
  if (type.isEarliestDate) date = formatDateTime(sortDateTime(file).first);
  if (type.isLatestDate) date = formatDateTime(sortDateTime(file).last);
  if (type.isExifDate) {
    DateTime dateTime = file.exifDate ?? sortDateTime(file).first;
    date = formatDateTime(dateTime);
  }
  return date.substring(0, dateDigit > date.length ? date.length : dateDigit);
}

List<DateTime> sortDateTime(FileInfo file) {
  List<DateTime> list = [file.createdDate, file.modifiedDate];
  if (file.exifDate != null) list.add(file.exifDate!);
  list.sort();
  return list;
}

/// 获取前缀
String prefixName(WidgetRef ref, int fileIndex, int prefixIndex) {
  bool swap = ref.watch(swapPrefixProvider);
  String widthStr = ref.watch(prefixLengthControllerProvider).text;
  int width = widthStr == '' ? 0 : getNum(widthStr);
  String num = formatNumber(prefixIndex, width);
  String prefixText = ref.watch(prefixControllerProvider).text;
  if (prefixText != '') {
    bool cycle = ref.watch(cyclePrefixProvider);
    List<String> list = [];
    if (prefixText.contains('\n')) list.addAll(prefixText.split('\r\n'));
    if (!prefixText.contains('\n') && prefixText.contains(' ')) {
      list.addAll(prefixText.trim().split(' '));
    }
    String indexStr = cycle
        ? list[fileIndex % list.length]
        : fileIndex >= list.length
            ? ''
            : list[fileIndex];
    prefixText = list.length < 2 ? prefixText : indexStr;
  }
  return swap ? prefixText + num : num + prefixText;
}

/// 获取后缀
String suffixName(WidgetRef ref, int fileIndex, int suffixIndex) {
  bool swap = ref.watch(swapSuffixProvider);
  String widthStr = ref.watch(suffixLengthControllerProvider).text;
  // int width = widthStr == '' ? 0 : int.parse(widthStr.replaceAll('位', ''));
  int width = widthStr == '' ? 0 : getNum(widthStr);
  String num = formatNumber(suffixIndex, width);
  String suffixText = ref.watch(suffixControllerProvider).text;
  if (suffixText != '') {
    bool cycle = ref.watch(cycleSuffixProvider);
    List<String> list = [];
    if (suffixText.contains('\n')) list.addAll(suffixText.split('\r\n'));
    if (!suffixText.contains('\n') && suffixText.contains(' ')) {
      list.addAll(suffixText.trim().split(' '));
    }
    String indexStr = cycle
        ? list[fileIndex % list.length]
        : fileIndex >= list.length
            ? ''
            : list[fileIndex];
    suffixText = list.length < 2 ? suffixText : indexStr;
  }
  return swap ? num + suffixText : suffixText + num;
}

void undo(WidgetRef ref) async {
  List<FileInfo> list = ref.watch(fileListProvider);
  List<FileInfo> checkList = list.where((e) => e.checked).toList();
  int total = checkList.length;
  if (checkList.isEmpty) return;
  List<NotificationInfo> errorList = [];

  ref.read(totalProvider.notifier).update(total);
  int count = 0;
  bool delay = list.length > AppNum.maxFileNum;
  int startTime = DateTime.now().microsecondsSinceEpoch;

  for (FileInfo file in checkList) {
    count++;
    String oldPath = file.filePath;
    String newPath = file.beforePath;
    if (oldPath == newPath) continue;
    NotificationInfo? info = await renameFile(ref, (file.id, oldPath, newPath));
    if (info != null) errorList.add(info);
    if (delay) await Future.delayed(const Duration(microseconds: 1));
  }
  ref.read(countProvider.notifier).update(count);
  renameTemp(ref);
  int endTime = DateTime.now().microsecondsSinceEpoch;
  double cost = (endTime - startTime) / 1000000;
  ref.read(costProvider.notifier).update(cost);
  bool isViewMode = ref.watch(viewModeProvider);
  if (isViewMode) ref.read(refreshImageProvider.notifier).update();
  updateName(ref);
  updateExtension(ref, true);
  NotificationType type = errorList.isNotEmpty
      ? ErrorNotification(S.current.undoFailed,
          S.current.undoFailedNum(errorList.length, total), errorList)
      : SuccessNotification(
          S.current.undoSuccessful, S.current.undoSuccessfulNum(total));
  NotificationMessage.show(type);
}

typedef RenameInfo = (String id, String oldPath, String newPath);

void renameTemp(WidgetRef ref) {
  List<RenameInfo> temp = ref.watch(tempListProvider);
  if (temp.isNotEmpty) {
    for (final info in temp) {
      renameFile(ref, info);
      ref.read(tempListProvider.notifier).remove(info);
    }
    List<RenameInfo> newTemp = ref.watch(tempListProvider);
    if (newTemp.isNotEmpty) {}
  }
}

Future<NotificationInfo?> renameFile(
    WidgetRef ref, RenameInfo renameInfo) async {
  final (id, oldPath, newPath) = renameInfo;
  String extension = getFileExtension(oldPath);
  bool isFolder = extension == folder;

  String oldName = path.basename(oldPath);
  String newName = path.basename(newPath);

  if (File(newPath).existsSync()) {
    List<FileInfo> list =
        ref.watch(fileListProvider).where((e) => e.checked).toList();
    FileInfo result =
        list.firstWhere((e) => e.filePath == newPath, orElse: () => nullFile);
    List<String> badList = ref.watch(badListProvider);
    if (result == nullFile || badList.contains(newPath)) {
      ref.read(badListProvider.notifier).add(oldPath);
    }
    if (result != nullFile && !badList.contains(newPath)) {
      renameFile(ref, (id, oldPath, newPath + id));
      ref.read(tempListProvider.notifier).add((id, newPath + id, newPath));
      return null;
    }
    return NotificationInfo(
        file: oldName, message: ' ${S.current.existsError(newName)}');
  }

  try {
    if (isFolder) {
      Directory(oldPath).renameSync(newPath);
    } else {
      File(oldPath).renameSync(newPath);
    }
    if (ref.watch(saveLogProvider)) tempSaveLog(ref, oldName, newName);
    final FileList fileInfo = ref.read(fileListProvider.notifier);
    String name = path.basenameWithoutExtension(newPath);
    fileInfo.updateOriginName(id, name);
    fileInfo.updateFilePath(id, newPath);
    String newExtension = getFileExtension(newPath);
    fileInfo.updateOriginExtension(id, newExtension);
    if (ref.watch(currentModeProvider).isOrganize) {
      fileInfo.updateFileParent(id, path.dirname(newPath));
    }
    return null;
  } catch (e) {
    Log.e(e.runtimeType.toString());
    String message = '';
    if (e.runtimeType == PathNotFoundException) {
      String parent = path.dirname(newPath);
      message = ': ${S.current.notExistsError(parent)}';
    } else {
      message = S.current.failedError(e);
    }
    String fileName = path.basename(oldPath);
    return NotificationInfo(file: fileName, message: message);
  }
}

void cSVDataRename(WidgetRef ref) {
  List<FileInfo> list = ref.watch(fileListProvider);
  List<EasyRenameInfo> easyList = ref.watch(cSVDataProvider);
  bool isA = ref.watch(cSVNameColumnProvider) == 'A';
  EasyRenameInfo badInfo = EasyRenameInfo(nameA: '', nameB: '');
  for (FileInfo file in list) {
    if (!file.checked) continue;
    if (isA) {
      EasyRenameInfo matching = easyList.firstWhere(
        (e) => e.nameA == file.name,
        orElse: () => badInfo,
      );
      if (matching != badInfo) {
        ref.read(fileListProvider.notifier).updateName(file.id, matching.nameB);
      } else {
        ref.read(fileListProvider.notifier).updateName(file.id, file.name);
      }
    } else {
      EasyRenameInfo matching = easyList.firstWhere((e) => e.nameB == file.name,
          orElse: () => badInfo);
      if (matching != badInfo) {
        ref.read(fileListProvider.notifier).updateName(file.id, matching.nameA);
      } else {
        ref.read(fileListProvider.notifier).updateName(file.id, file.name);
      }
    }
  }
}
