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
import 'package:path_provider/path_provider.dart';

void updateExtension(WidgetRef ref) {
  List<FileInfo> files = ref.read(fileListProvider);
  String inputExt = ref.watch(extensionControllerProvider).text;
  bool isModifyExt = ref.watch(modifyExtensionProvider);
  for (var file in files) {
    String newExt = file.extension;
    if (file.checked && !file.type.isFolder && isModifyExt) newExt = inputExt;
    ref.read(fileListProvider.notifier).updateExtension(file.id, newExt);
  }
}

int actualIndex(WidgetRef ref, DateFormatMap dfMap, FileInfo file) {
  // Log.i(dfMap.toString());
  // 默认 index 为 0
  int index = 0;
  // 获取日期名称
  String dateText = dateName(ref, file);
  // 获取列表中的所有以日期为名的 key
  List<String> dateKeyList = dfMap.keys.toList();
  // 获取当前文件的格式分类名称
  String classify = getFileClassifyName(file.type);
  // 如果获取的日期列表中包含了当前的日期
  if (dateKeyList.contains(dateText)) {
    // 获取当前日期下的多有格式分类
    List<String> classifyList = dfMap[dateText]!.keys.toList();
    // 查看日期下是否有当前分类
    if (classifyList.contains(classify)) {
      // 如果有当前分类就获取文件的长度并将该文件添加到数组中
      List<String>? fileNameList = dfMap[dateText]![classify];
      index += fileNameList!.length;
      fileNameList.add(file.name);
    } else {
      // 如果没有当前分类就添加当前分类并添加文件到数组中
      dfMap[dateText]?.addAll({
        classify: [file.name]
      });
    }
  } else {
    dfMap.addAll({
      dateText: {
        classify: [file.name]
      }
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
  bool dateRename = ref.watch(dateRenameProvider);
  for (var file in files) {
    if (file.checked) {
      // 实际索引 = 以日期命名 ?  : 0;
      int actualFileIndex = dateRename ? actualIndex(ref, dfMap, file) : 0;
      int actualPrefixIndex = prefixIndex + actualFileIndex;
      int actualSuffixIndex = suffixIndex + actualFileIndex;
      String newName = matchContent(
          ref, file, fileIndex, actualPrefixIndex, actualSuffixIndex);
      ref.read(fileListProvider.notifier).updateName(file.id, newName);
      fileIndex++;
      if (!dateRename) {
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

  for (final file in checkList) {
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
  updateExtension(ref);
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
    if (ref.watch(saveLogProvider)) {
      Directory docPath = await getApplicationDocumentsDirectory();
      String filePath = path.join(docPath.path, 'OncePower');
      Directory dir = Directory(filePath);
      if (!dir.existsSync()) await dir.create();
      createLog(filePath, S.current.renameLogs, oldName, newName);
    }
    final fileInfo = ref.read(fileListProvider.notifier);
    String name = path.basenameWithoutExtension(newPath);
    fileInfo.updateOriginName(id, name);
    fileInfo.updateFilePath(id, newPath);
    String newExtension = getFileExtension(newPath);
    fileInfo.updateOriginExtension(id, newExtension);
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
  List<EasyRenameInfo> easyList = ref.watch(easyRenameInfoListProvider);
  bool isA = ref.watch(cSVNameColumnProvider) == 0;
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
