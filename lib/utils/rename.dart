import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/format.dart';

import 'mode.dart';

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

int actualIndex(
    dynamic ref, List<Map<String, List<String>>> array, FileInfo file) {
  int index = 0;
  String dateText = dateName(ref, file);
  List<String> keyList = array.map((e) => e.keys.first).toList();
  if (keyList.contains(dateText)) {
    Map<String, List<String>> map =
        array.firstWhere((e) => e.keys.first == dateText);
    List<String> fileList = map.values.first;

    index += fileList.length;
    map[dateText]?.add(file.name);
  } else {
    array.add({
      dateText: [file.name]
    });
  }
  return index;
}

void updateName(dynamic ref) {
  List<FileInfo> files = ref.read(sortListProvider);
  String prefixIndexText = ref.watch(prefixStartControllerProvider).text;
  int prefixIndex = int.parse(prefixIndexText.replaceAll('开始', ''));
  String suffixIndexText = ref.watch(suffixStartControllerProvider).text;
  int suffixIndex = int.parse(suffixIndexText.replaceAll('开始', ''));
  int fileIndex = 0;
  List<Map<String, List<String>>> fileArray = [];
  bool dateRename = ref.watch(dateRenameProvider);
  for (var file in files) {
    if (file.checked) {
      int actualFileIndex = dateRename ? actualIndex(ref, fileArray, file) : 0;
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
  int dateDigit = int.parse(dateDigitText.replaceAll('位', ''));
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
  int width = widthStr == '' ? 0 : int.parse(widthStr.replaceAll('位', ''));
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
  int width = widthStr == '' ? 0 : int.parse(widthStr.replaceAll('位', ''));
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
