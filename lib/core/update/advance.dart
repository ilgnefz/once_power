import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/rule.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/model/rule.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/src/rust/api/simple.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/util/storage.dart';
import 'package:path/path.dart';

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
    String name = file.name, extension = file.extension;
    for (AdvanceMenuModel menu in menus) {
      if (menu.group != 'all' && menu.group != file.group) continue;
      switch (menu.type) {
        case AdvanceType.delete:
          menu as AdvanceMenuDelete;
          if (menu.mode.isExtension) {
            extension = '';
          } else {
            name = advanceDeleteName(menu, name);
          }
        case AdvanceType.add:
          menu as AdvanceMenuAdd;
          (name, extension) = advanceAddName(menu, file, index);
        case AdvanceType.replace:
          menu as AdvanceMenuReplace;
          name = advanceReplaceName(menu, name);
      }
    }
    name = removeForbiddenCharacters(name);
    provider.updateNewName(file.id, name);
    provider.updateNewExtension(file.id, extension);
    index++;
  }
}

String changeMatch(
  MatchContent matchContent,
  String name,
  String value,
  String replace,
  int number,
  int front,
  int behind,
) {
  switch (matchContent) {
    case MatchContent.number:
      final List<String> parts = name.split(value);
      if (number >= parts.length) return name;
      parts[number - 1] = parts[number - 1] + replace + parts[number];
      parts.removeAt(number);
      List<String> part1 = parts.sublist(0, number);
      List<String> part2 = parts.sublist(number);
      print('$part1 --- $part2');
      return parts.join(value);
    case MatchContent.last:
      int index = name.lastIndexOf(value);
      if (index == -1) return name;
      return name.replaceRange(index, index + value.length, replace);
    case MatchContent.all:
      return name.replaceAll(value, replace);
  }
}

String positionValue(
  MatchPosition position,
  String name,
  String value,
  String replace,
  int front,
  int behind,
) {
  switch (position) {
    case MatchPosition.self:
      return name;
    case MatchPosition.front:
      name = name.split('').reversed.join('');
      String result = insertReplace(name, value, replace, front);
      return result.split('').reversed.join('');
    case MatchPosition.behind:
      return insertReplace(name, value, replace, behind);
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
