import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/models/file_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/two_re_enum.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/list.dart';
import 'package:once_power/utils/utils.dart';

void advanceUpdateName(WidgetRef ref) {
  List<FileInfo> fileList = ref.watch(sortListProvider);
  List<AdvanceMenuModel> menus =
      ref.watch(advanceMenuListProvider).where((menu) => menu.checked).toList();
  int index = 0;
  Map<String, List<FileInfo>> classifyMap = {};
  for (FileInfo file in fileList) {
    if (!file.checked) {
      ref.read(fileListProvider.notifier).updateName(file.id, file.name);
      continue;
    }
    String name = file.name;
    String extension = file.extension;
    for (AdvanceMenuModel menu in menus) {
      if (menu.type.isDelete) {
        menu as AdvanceMenuDelete;
        if (menu.deleteExt) extension = '';
        name = advanceDeleteName(menu, name);
      }
      if (menu.type.isAdd) {
        menu as AdvanceMenuAdd;
        String folder = getFolderName(file.parent);
        String type = file.type.label;
        if (menu.distinguishType.isFolder) {
          (_, index) = calculateIndex(classifyMap, [folder], file);
        }
        if (menu.distinguishType.isExtension) {
          (_, index) = calculateIndex(classifyMap, [extension], file);
        }
        if (menu.distinguishType.isFile) {
          (_, index) = calculateIndex(classifyMap, [type], file);
        }
        name = advanceAddName(menu, file, name, index, folder);
      }
      if (menu.type.isReplace) {
        name = advanceReplaceName(menu as AdvanceMenuReplace, name);
      }
    }
    ref.read(fileListProvider.notifier).updateName(file.id, name);
    ref.read(fileListProvider.notifier).updateExtension(file.id, extension);
    index++;
  }
}

String advanceDeleteName(AdvanceMenuDelete menu, String name) {
  String value = menu.value;
  MatchLocation location = menu.matchLocation;
  List<DeleteType> deleteTypes = menu.deleteTypes;
  if (deleteTypes.isNotEmpty) {
    for (DeleteType type in deleteTypes) {
      switch (type) {
        case DeleteType.digit:
          name = name.replaceAll(RegExp(r'[0-9]'), '');
          break;
        case DeleteType.capitalLetter:
          name = name.replaceAll(RegExp(r'[A-Z]'), '');
          break;
        case DeleteType.lowercaseLetters:
          name = name.replaceAll(RegExp(r'[a-z]'), '');
          break;
        case DeleteType.nonLetter:
          String pattern =
              r'\u4e00-\u9fff\u3040-\u309f\u30a0-\u30ff\uac00-\ud7af\u0f00-\u0fff';
          name = name.replaceAll(RegExp("[$pattern]"), '');
          break;
        case DeleteType.punctuation:
          String pattern =
              r"()\~!@#\$%\^&,'\.;_\[\]`\{\}\-=+！，。？：、‘’“”（）【】{}<>《》「」";
          name = name.replaceAll(RegExp("[$pattern]"), '');
          break;
        case DeleteType.space:
          name = name.replaceAll(' ', '');
          break;
      }
    }
    return name;
  }
  switch (location) {
    case MatchLocation.first:
      name = name.replaceFirst(value, '');
      return name;
    case MatchLocation.last:
      int index = name.lastIndexOf(value);
      if (index != -1) {
        name = name.substring(0, index) + name.substring(index + value.length);
      }
      return name;
    case MatchLocation.all:
      name = name.replaceAll(value, '');
      return name;
    case MatchLocation.position:
      return matchPosition(name, '', menu.start, menu.end);
    case MatchLocation.front:
      int index = name.indexOf(value);
      if (index == -1 || index == 0) return name;
      int start = index - menu.front;
      start = start < 0 ? 0 : start;
      return matchPosition(name, '', start + 1, index);
    case MatchLocation.back:
      int index = name.indexOf(value);
      if (index == -1 || index == name.length - 1) return name;
      int start = index + value.length + 1;
      int end = start + menu.back;
      end = end > name.length ? name.length : end - 1;
      return matchPosition(name, '', start, end);
  }
}

String advanceAddName(
  AdvanceMenuAdd menu,
  FileInfo file,
  String name,
  int index,
  String folder,
) {
  String value = menu.value;
  int digits = menu.digits;
  int start = menu.start + index;
  AddType addType = menu.addType;
  DateType dateType = menu.dateType;
  AddPosition addPosition = menu.addPosition;
  int posIndex = menu.posIndex;
  if (!addType.isSerialNumber) {
    if (addType.isParentsName) value = folder;
    if (addType.isExtension) value = getDotWithExt(file.extension);
    if (addType.isRandom) {
      value = getRandomValue(menu.randomValue, menu.randomLen);
    }
    if (addType.isDate) value = getDateName(dateType, 8, file);
    if (addType.isWidth) {
      value = file.dimensions == null ? '' : file.dimensions!.width.toString();
    }
    if (addType.isHeight) {
      value = file.dimensions == null ? '' : file.dimensions!.height.toString();
    }
    switch (addPosition) {
      case AddPosition.before:
        if (posIndex > name.length) {
          posIndex = name.length;
          name = '$name$value';
        } else {
          String left = name.substring(0, posIndex - 1);
          String right = name.substring(posIndex - 1);
          name = '$left$value$right';
        }
        break;
      case AddPosition.after:
        int adjustedPos = name.length - (posIndex - 1);
        if (adjustedPos < 0) adjustedPos = 0;
        if (adjustedPos > name.length) {
          name = name + value;
        } else {
          String left = name.substring(0, adjustedPos);
          String right = name.substring(adjustedPos);
          name = '$left$value$right';
        }
        break;
    }
  }
  if (addType.isSerialNumber) {
    String num = formatNum(start, digits);
    name = addPosition.isBefore ? '$num$name' : '$name$num';
  }
  return name;
}

String advanceReplaceName(AdvanceMenuReplace menu, String name) {
  String oldValue = menu.value[0];
  String newValue = menu.value[1];
  CaseType type = menu.caseType;
  ReplaceMode mode = menu.replaceMode;
  if (mode.isFormat) {
    int num = int.parse(oldValue);
    if (name.length > num) {
      name = name.substring(0, num);
    } else {
      if (menu.fillPosition.isFront) name = name.padLeft(num, newValue);
      if (menu.fillPosition.isBack) name = name.padRight(num, newValue);
    }
    return name;
  }

  if (!mode.isFormat && menu.wordSpacing != '') {
    return splitWords(name).join(menu.wordSpacing);
  }

  switch (type) {
    case CaseType.uppercase:
      return name.toUpperCase();
    case CaseType.lowercase:
      return name.toLowerCase();
    case CaseType.toggleCase:
      String result = '';
      for (int i = 0; i < name.length; i++) {
        String char = name[i];
        if (char == char.toUpperCase()) {
          result += char.toLowerCase();
        } else {
          result += char.toUpperCase();
        }
      }
      return result;
    case CaseType.noConversion:
      MatchLocation location = menu.matchLocation;
      switch (location) {
        case MatchLocation.first:
          name = name.replaceFirst(oldValue, newValue);
          return name;
        case MatchLocation.last:
          int index = name.lastIndexOf(oldValue);
          if (index != -1) {
            name = name.substring(0, index) +
                name.substring(index + oldValue.length) +
                newValue;
          }
          return name;
        case MatchLocation.all:
          name = name.replaceAll(oldValue, newValue);
          return name;
        case MatchLocation.position:
          return matchPosition(name, newValue, menu.start, menu.end);
        case MatchLocation.front:
          int index = name.indexOf(oldValue);
          if (index == -1 || index == 0) return name;
          int start = index - menu.front;
          start = start < 0 ? 0 : start;
          return matchPosition(name, newValue, start + 1, index);
        case MatchLocation.back:
          int index = name.indexOf(oldValue);
          if (index == -1 || index == name.length - 1) return name;
          int start = index + oldValue.length + 1;
          int end = start + menu.back;
          end = end > name.length ? name.length : end - 1;
          return matchPosition(name, newValue, start, end);
      }
  }
}

String matchPosition(String name, String replaceStr, int start, int end) {
  if (start > name.length) return name;
  if (end > name.length || end < start) end = name.length;
  String left = name.substring(0, start - 1);
  String right = name.substring(end);
  return left + replaceStr + right;
}

List<String> splitWords(String name) {
  final List<int> uppercaseIndices = [];
  for (int i = 0; i < name.length; i++) {
    final char = name[i];
    // 仅识别 A-Z 的大写字母（ASCII 65-90）
    if (char.codeUnitAt(0) >= 65 && char.codeUnitAt(0) <= 90) {
      uppercaseIndices.add(i);
    }
  }

  // 没有大写字母直接返回
  if (uppercaseIndices.isEmpty) return [name];

  final List<String> result = [];
  final int firstUpperIndex = uppercaseIndices[0];

  // 添加第一个大写字母前的部分（如 "a" in "aBC"）
  if (firstUpperIndex > 0) {
    result.add(name.substring(0, firstUpperIndex));
  }

  // 按大写字母位置分段（如 "B", "Caa22", "Hg好"）
  for (int i = 0; i < uppercaseIndices.length; i++) {
    final start = uppercaseIndices[i];
    final end = (i < uppercaseIndices.length - 1)
        ? uppercaseIndices[i + 1]
        : name.length;
    result.add(name.substring(start, end));
  }
  return result;
}
