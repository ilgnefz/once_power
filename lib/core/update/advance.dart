import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/rule.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/advance_add.dart';
import 'package:once_power/model/advance_delete.dart';
import 'package:once_power/model/advance_replace.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/model/rule.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/util/storage.dart';

import 'advance_add.dart';
import 'advance_delete.dart';
import 'advance_replace.dart';

Future<void> advanceUpdateName(WidgetRef ref) async {
  List<FileInfo> list = ref.read(sortListProvider);
  final FileList provider = ref.read(fileListProvider.notifier);
  List<AdvanceMenuModel> menus = ref
      .watch(advanceMenuListProvider)
      .where((menu) => menu.checked)
      .toList();
  Map<String, dynamic> classifyMap = {};
  int index = 0;
  for (FileInfo file in list) {
    if (!file.checked) continue;
    String name = file.name, ext = file.extension;
    for (AdvanceMenuModel menu in menus) {
      if (menu.group != 'all' && menu.group != file.group) continue;
      switch (menu.type) {
        case AdvanceType.delete:
          menu as AdvanceMenuDelete;
          if (menu.mode.isExtension) {
            ext = '';
          } else {
            name = advanceDeleteName(menu, name);
          }
          break;
        case AdvanceType.add:
          menu as AdvanceMenuAdd;
          if (menu.mode.isIndex) {
            index = getAddIndex(index, file, menu, classifyMap);
          }
          (name, ext) = advanceAddName(menu, file, index, name, ext);
          break;
        case AdvanceType.replace:
          menu as AdvanceMenuReplace;
          name = advanceReplaceName(menu, name);
          break;
      }
    }
    name = removeForbiddenCharacters(name);
    provider.updateNewName(file.id, name);
    provider.updateNewExtension(file.id, ext);
    index++;
  }
}

String changeMatch(
  MatchContent matchContent,
  AdvanceMatch match,
  String name,
  String value,
  String replace,
) {
  MatchPosition position = match.position;
  final List<String> parts = name.split(value);
  if (parts.length == 1) return name;
  switch (matchContent) {
    case MatchContent.number:
      int number = match.contentIndex;
      if (number >= parts.length) return name;
      List<String> part1 = parts.sublist(0, number);
      List<String> part2 = parts.sublist(number);
      return positionSingleValue(position, match, part1, part2, value, replace);
    case MatchContent.last:
      int number = parts.length - 1;
      List<String> part1 = parts.sublist(0, number);
      List<String> part2 = parts.sublist(number);
      return positionSingleValue(position, match, part1, part2, value, replace);
    case MatchContent.all:
      return positionAllValue(position, match, name, value, replace);
  }
}

String positionSingleValue(
  MatchPosition position,
  AdvanceMatch match,
  List<String> part1,
  List<String> part2,
  String value,
  String replace,
) {
  switch (position) {
    case MatchPosition.self:
      return part1.join(value) + replace + part2.join(value);
    case MatchPosition.front:
      int front = match.frontIndex;
      String subStr = part1.last;
      part1[part1.length - 1] = front >= subStr.length
          ? replace
          : subStr.substring(0, subStr.length - front) + replace;
      part1.addAll(part2);
      return part1.join(value);
    case MatchPosition.behind:
      int behind = match.behindIndex;
      String subStr = part2.first;
      part2[0] = behind >= subStr.length
          ? replace
          : replace + subStr.substring(behind);
      part1.addAll(part2);
      return part1.join(value);
  }
}

String positionAllValue(
  MatchPosition position,
  AdvanceMatch match,
  String name,
  String value,
  String replace,
) {
  switch (position) {
    case MatchPosition.self:
      return name.split(value).join(replace);
    case MatchPosition.front:
      int front = match.frontIndex;
      List<String> parts = name.split(value);
      for (int i = 0; i < parts.length; i++) {
        if (i == parts.length - 1) continue;
        String temp = parts[i];
        parts[i] = front >= temp.length
            ? replace
            : temp.substring(0, temp.length - front) + replace;
      }
      return parts.join(value);
    case MatchPosition.behind:
      int behind = match.behindIndex;
      List<String> parts = name.split(value);
      for (int i = 1; i < parts.length; i++) {
        String temp = parts[i];
        parts[i] = behind >= temp.length
            ? replace
            : replace + temp.substring(behind);
      }
      return parts.join(value);
  }
}

String insertReplace(String name, String match, String modify, int num) {
  List<String> list = name.split(match);
  String result = list[0];
  for (int i = 1; i < list.length; i++) {
    String part = num >= list[i].length ? '' : list[i].substring(num);
    result = result + match + modify + part;
  }
  return result;
}

Future<void> autoGroupFile(WidgetRef ref, List<GroupRule> list) async {
  if (list.isEmpty) return;
  List<FileInfo> files = ref.watch(sortListProvider);
  List<FileInfo> checkedFiles = files.where((e) => e.checked).toList();
  for (GroupRule item in list) {
    InfoType type = item.infoType;
    ComparisonOperator operator = item.operator;
    String value = item.value;
    String group = item.group;
    for (FileInfo file in checkedFiles) {
      String info = getRuleTypeValue(type, file);
      if (getCompareResult(operator, value, info)) {
        if (group != '') {
          List<String> list = StorageUtil.getStringList(AppKeys.groupList);
          if (!list.contains(group)) {
            list.add(group);
            await StorageUtil.setStringList(AppKeys.groupList, list);
          }
        }
        ref.read(fileListProvider.notifier).updateGroup(file.id, group);
      }
    }
  }
  advanceUpdateName(ref);
}
