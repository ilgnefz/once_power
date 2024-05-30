import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/utils/log.dart';
import 'package:once_power/utils/type.dart';

import 'mode.dart';

// Map<String, Map<String, List<String>>> map = {
//     "today": {"jpg": [], "mp4": []},
//     "yesterday": {"jpg": [], "mp4": []},
//   };
typedef DateFormatMap = Map<String, Map<String, List<String>>>;

void updateExtension(dynamic ref) {
  List<FileInfo> files = ref.read(fileListProvider);
  for (var file in files) {
    if (file.checked && file.type != FileClassify.folder) {
      String newExtension = ref.watch(extensionControllerProvider).text;
      String newExt = newExtension == '' ? file.extension : newExtension;
      ref.read(fileListProvider.notifier).updateExtension(file.id, newExt);
    } else {
      ref
          .read(fileListProvider.notifier)
          .updateExtension(file.id, file.extension);
    }
  }
}

int actualIndex(dynamic ref, DateFormatMap dfMap, FileInfo file) {
  Log.i(dfMap.toString());
  // 默认 index 为 0
  int index = 0;
  // 获取日期名称
  String dateText = dateName(ref, file);
  // 获取列表中的所有以日期为名的 key
  List<String> dateKeyList = dfMap.keys.toList();
  // 获取当前文件的格式分类名称
  String extensionName = getFileClassifyName(file.extension);
  // 如果获取的日期列表中包含了当前的日期
  if (dateKeyList.contains(dateText)) {
    // 获取当前日期下的多有格式分类
    List<String> extensionList = dfMap[dateText]!.keys.toList();
    // 查看日期下是否有当前分类
    if (extensionList.contains(extensionName)) {
      // 如果有当前分类就获取文件的长度并将该文件添加到数组中
      List<String>? fileNameList = dfMap[dateText]![extensionName];
      index += fileNameList!.length;
      fileNameList.add(file.name);
    } else {
      // 如果没有当前分类就添加当前分类并添加文件到数组中
      dfMap[dateText]?.addAll({
        extensionName: [file.name]
      });
    }
  } else {
    dfMap.addAll({
      dateText: {
        extensionName: [file.name]
      }
    });
  }
  return index;
}

void updateName(dynamic ref) {
  List<FileInfo> files = ref.read(sortListProvider);
  String prefixIndexText = ref.watch(prefixStartControllerProvider).text;
  // int prefixIndex = int.parse(prefixIndexText.replaceAll('开始', ''));
  int prefixIndex = getNum(prefixIndexText);
  String suffixIndexText = ref.watch(suffixStartControllerProvider).text;
  // int suffixIndex = int.parse(suffixIndexText.replaceAll('开始', ''));
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

String matchContent(dynamic ref, FileInfo file, int fileIndex, int prefixIndex,
    int suffixIndex) {
  FunctionMode mode = ref.watch(currentModeProvider);
  bool isLength = ref.watch(inputLengthProvider);
  bool matchCase = ref.watch(matchCaseProvider);
  bool dateRename = ref.watch(dateRenameProvider);
  String? dateText = dateRename ? dateName(ref, file) : null;
  String matchText = ref.watch(matchControllerProvider).text;
  String modifyText = ref.watch(modifyControllerProvider).text;
  String name = file.name;

  if (mode == FunctionMode.replace) {
    RemoveType removeType = ref.watch(currentRemoveTypeProvider);
    name = replaceName(
        removeType, matchText, modifyText, name, isLength, matchCase, dateText);
  }

  if (mode == FunctionMode.reserve) {
    name = reserveName(
        ref, matchText, modifyText, name, isLength, matchCase, dateText);
  }

  name = prefixName(ref, fileIndex, prefixIndex) +
      name +
      suffixName(ref, fileIndex, suffixIndex);
  return name;
}

String dateName(WidgetRef ref, FileInfo file) {
  String date = '';
  String dateDigitText = ref.watch(dateLengthControllerProvider).text;
  // int dateDigit = int.parse(dateDigitText.replaceAll('位', ''));
  int dateDigit = getNum(dateDigitText);
  DateType type = ref.watch(currentDateTypeProvider);
  if (type == DateType.modifiedDate) date = formatDateTime(file.modifiedDate);
  if (type == DateType.earliestDate) {
    date = formatDateTime(sortDateTime(file).first);
  }
  if (type == DateType.latestDate) {
    date = formatDateTime(sortDateTime(file).last);
  }
  if (type == DateType.createdDate) date = formatDateTime(file.createdDate);
  if (type == DateType.exifDate) {
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
  // int width = widthStr == '' ? 0 : int.parse(widthStr.replaceAll('位', ''));
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
