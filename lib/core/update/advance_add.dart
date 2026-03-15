import 'dart:math';

import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/advance_add.dart';
import 'package:once_power/model/file.dart';

(String, String) advanceAddName(AdvanceMenuAdd menu, FileInfo file, int index) {
  String name = file.name, ext = file.extension;

  switch (menu.mode) {
    case AddMode.text:
      return insertPosition(menu, name, menu.value, ext);
    case AddMode.indexes:
      return insertPosition(menu, name, menu.value, ext);
    case AddMode.random:
      const expandMap = {
        'a-z': 'abcdefghijklmnopqrstuvwxyz',
        'A-Z': 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
        '0-9': '0123456789',
      };
      final values = menu.randomValue
          .expand((v) => [expandMap[v] ?? v])
          .toSet();
      String value = getRandomValue(values, menu.randomLength);
      return insertPosition(menu, name, value, ext);
    case AddMode.folder:
      return insertPosition(menu, name, menu.value, ext);
    case AddMode.width:
      return insertPosition(menu, name, menu.value, ext);
    case AddMode.height:
      return insertPosition(menu, name, menu.value, ext);
    case AddMode.extension:
      return insertPosition(menu, name, menu.value, ext);
    case AddMode.group:
      return insertPosition(menu, name, menu.value, ext);
    case AddMode.date:
      return insertPosition(menu, name, menu.value, ext);
    case AddMode.metaData:
      return insertPosition(menu, name, menu.value, ext);
  }
}

String getRandomValue(Set<String> list, int len) {
  if (list.isEmpty) return '';
  Random random = Random();
  String content = list.join('');
  String result = '';
  for (int i = 0; i < len; i++) {
    int index = random.nextInt(content.length);
    result += content[index];
  }
  return result;
}

(String, String) insertPosition(
  AdvanceMenuAdd menu,
  String name,
  String value,
  String ext,
) {
  int index = menu.positionIndex;
  switch (menu.addPosition) {
    case AddPosition.front:
      List<String> list = name.split('');
      index = index > list.length ? list.length : index - 1;
      list.insert(index, value);
      return (list.join(''), ext);
    case AddPosition.behind:
      List<String> list = name.split('').reversed.toList();
      index = index > list.length ? list.length : index - 1;
      list.insert(index, value);
      return (list.reversed.join(''), ext);
    case AddPosition.end:
      return (name, '$ext$value');
    case AddPosition.interval:
      if (name.isEmpty) return (name, ext);
      List<String> result = [];
      for (int i = 0; i < name.length; i += index) {
        int end = (i + index < name.length) ? i + index : name.length;
        result.add(name.substring(i, end));
      }
      return (result.join(value), ext);
  }
}
