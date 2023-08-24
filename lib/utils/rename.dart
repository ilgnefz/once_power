import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/format.dart';

import 'mode.dart';

// part 'rename.g.dart';

void updateExtension(dynamic ref) {
  List<RenameFile> files = ref.read(fileListProvider);
  for (var file in files) {
    if (file.checked) {
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

void updateName(dynamic ref) {
  List<RenameFile> files = ref.read(fileListProvider);
  String prefixIndexText = ref.watch(prefixStartControllerProvider).text;
  int prefixIndex = int.parse(prefixIndexText.replaceAll('开始', ''));
  String suffixIndexText = ref.watch(suffixStartControllerProvider).text;
  int suffixIndex = int.parse(suffixIndexText.replaceAll('开始', ''));
  int fileIndex = 0;
  for (var file in files) {
    if (file.checked) {
      String newName =
          matchContent(ref, file, fileIndex, prefixIndex, suffixIndex);
      ref.read(fileListProvider.notifier).updateName(file.id, newName);
      fileIndex++;
      prefixIndex++;
      suffixIndex++;
    } else {
      ref.read(fileListProvider.notifier).updateName(file.id, file.name);
    }
  }
}

String matchContent(dynamic ref, RenameFile file, int fileIndex,
    int prefixIndex, int suffixIndex) {
  FunctionMode mode = ref.watch(currentModeProvider);
  bool isLength = ref.watch(inputLengthProvider);
  bool matchCase = ref.watch(matchCaseProvider);
  bool dateRename = ref.watch(dateRenameProvider);
  String? dateText = dateRename ? dateName(ref, file) : null;
  String matchText = ref.watch(matchControllerProvider).text;
  String modifyText = ref.watch(modifyControllerProvider).text;
  String name = file.name;

  if (mode == FunctionMode.replace) {
    name =
        replaceName(matchText, modifyText, name, isLength, matchCase, dateText);
  }

  if (mode == FunctionMode.reserve) {
    name = reserveName(ref, matchText, name, isLength, matchCase, dateText);
  }

  if (mode == FunctionMode.remove) {
    RemoveType removeType = ref.watch(currentRemoveTypeProvider);
    name = removeName(removeType, matchText, name, isLength, matchCase);
  }

  name = prefixName(ref, fileIndex, prefixIndex) +
      name +
      suffixName(ref, fileIndex, suffixIndex);
  return name;
}

/// 获取日期
String dateName(WidgetRef ref, RenameFile file) {
  List<DateTime> list = [file.createDate, file.modifyDate];
  if (file.exifDate != null) list.add(file.exifDate!);
  list.sort();
  String date = '';
  String dateDigitText = ref.watch(dateLengthControllerProvider).text;
  int dateDigit = int.parse(dateDigitText.replaceAll('位', ''));
  DateType type = ref.watch(currentDateTypeProvider);
  if (type == DateType.modifyDate) date = formatDateTime(file.modifyDate);
  if (type == DateType.earliestDate) date = formatDateTime(list.first);
  if (type == DateType.latestDate) date = formatDateTime(list.last);
  if (type == DateType.createDate) date = formatDateTime(file.createDate);
  if (type == DateType.exifDate) {
    DateTime dateTime = file.exifDate ?? list.first;
    date = formatDateTime(dateTime);
  }
  return date.substring(0, dateDigit > date.length ? date.length : dateDigit);
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
