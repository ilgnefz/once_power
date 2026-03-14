import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/src/rust/api/simple.dart';

import 'advance.dart';

String advanceReplaceName(AdvanceMenuReplace menu, String name) {
  String match = menu.value[0], modify = menu.value[1];
  if (menu.useRegex) return name.replaceAll(RegExp(match), modify);
  switch (menu.mode) {
    case ReplaceMode.normal:
      return changeMatch(
        menu.matchContent,
        name,
        match,
        modify,
        menu.number,
        menu.front,
        menu.behind,
      );
    case ReplaceMode.convert:
      switch (menu.convertType) {
        case ConvertType.uppercase:
          return name.toUpperCase();
        case ConvertType.lowercase:
          return name.toLowerCase();
        case ConvertType.toggleCase:
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
        case ConvertType.traditional:
          return simplifiedToTraditional(text: name);
        case ConvertType.simplified:
          return traditionalToSimplified(text: name);
      }
    case ReplaceMode.format:
      int? num = int.tryParse(match);
      int length = num ?? match.length;
      if (name.length > length) return name.substring(0, num);
      return menu.fillPosition.isFront
          ? name.padLeft(length, modify)
          : name.padRight(length, modify);
    case ReplaceMode.position:
      int start = menu.start - 1, length = menu.length;
      int end = start + length;
      if (start + length > name.length) end = name.length;
      return name.replaceRange(start, end, modify);
    case ReplaceMode.separator:
      return splitWords(name).join(menu.wordSpacing);
  }
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
