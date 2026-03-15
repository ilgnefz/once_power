import 'dart:math';

import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/advance_add.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/util/verify.dart';

import 'normal.dart';

(String, String) advanceAddName(
  AdvanceMenuAdd menu,
  FileInfo file,
  int index,
  String name,
  String extension,
) {
  switch (menu.mode) {
    case AddMode.text:
      return insertPosition(menu, name, menu.value, extension);
    case AddMode.indexes:
      int width = menu.advanceIndex.width, start = menu.advanceIndex.start;
      String indexStr = formatNum(start + index, width);
      return insertPosition(menu, name, indexStr, extension);
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
      return insertPosition(menu, name, value, extension);
    case AddMode.folder:
      String folder = getFolderName(file.parent);
      return insertPosition(menu, name, folder, extension);
    case AddMode.width:
      String width = file.resolution?.width.toString() ?? '';
      return insertPosition(menu, name, width, extension);
    case AddMode.height:
      String height = file.resolution?.height.toString() ?? '';
      return insertPosition(menu, name, height, extension);
    case AddMode.extension:
      return insertPosition(menu, name, file.extension, extension);
    case AddMode.group:
      String group = isAll(file.group) ? '' : file.group;
      return insertPosition(menu, name, group, extension);
    case AddMode.date:
      return insertPosition(menu, name, menu.value, extension);
    case AddMode.metaData:
      String metaData = '';
      switch (menu.metaData.type) {
        case MetaDataType.title:
          metaData = file.metaInfo?.title ?? '';
          break;
        case MetaDataType.artist:
          metaData = file.metaInfo?.artist ?? '';
          break;
        case MetaDataType.album:
          metaData = file.metaInfo?.album ?? '';
          break;
        case MetaDataType.year:
          metaData = file.metaInfo?.year ?? '';
          break;
        case MetaDataType.make:
          metaData = file.metaInfo?.make ?? '';
          break;
        case MetaDataType.model:
          metaData = file.metaInfo?.model ?? '';
          break;
        case MetaDataType.location:
          metaData = file.metaInfo?.location ?? '';
          break;
      }
      return insertPosition(menu, name, metaData, extension);
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

int getAddIndex(
  int index,
  FileInfo file,
  AdvanceMenuAdd menu,
  Map<String, dynamic> classifyMap,
) {
  switch (menu.advanceIndex.distinction) {
    case IndexDistinction.none:
      return index;
    case IndexDistinction.file:
      String type = file.type.label;
      (_, index) = calculateIndex(classifyMap, [type], file);
    case IndexDistinction.extension:
      String extension = file.extension;
      (_, index) = calculateIndex(classifyMap, [extension], file);
    case IndexDistinction.date:
      DateType distinguishDate = menu.advanceIndex.dateType;
      String indexDate = getDateName(getDate(distinguishDate, file)?.date, 8);
      (_, index) = calculateIndex(classifyMap, [indexDate], file);
    case IndexDistinction.folder:
      String folder = getFolderName(file.parent);
      (_, index) = calculateIndex(classifyMap, [folder], file);
    case IndexDistinction.group:
      (_, index) = calculateIndex(classifyMap, [file.group], file);
  }
  return index;
}
