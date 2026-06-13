import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/advance_replace.dart';
import 'package:once_power/src/rust/api/simple.dart';

import 'advance.dart';

String advanceReplaceName(AdvanceMenuReplace menu, String name) {
  String oldValue = menu.value[0], newValue = menu.value[1];
  if (menu.useRegex) return name.replaceAll(RegExp(oldValue), newValue);
  switch (menu.mode) {
    case ReplaceMode.normal:
      AdvanceMatch match = menu.match;
      return changeMatch(menu.match.content, match, name, oldValue, newValue);
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
    case ReplaceMode.swap:
      SwapMenu swap = menu.swap;
      switch (swap.type) {
        case SwapType.reverse:
          return name.split('').reversed.join('');
        case SwapType.custom:
          String separator = swap.separator;
          if (separator.isEmpty) return name;
          List<String> letters = name.split(separator);
          int index = swap.index;
          if (index >= letters.length) return name;
          if (swap.all) {
            List<String> part1 = letters.sublist(0, index);
            List<String> part2 = letters.sublist(index);
            return part2.join(separator) + separator + part1.join(separator);
          } else {
            String temp = letters[index];
            letters[index] = letters[index - 1];
            letters[index - 1] = temp;
            return letters.join(separator);
          }
      }
    case ReplaceMode.format:
      int? num = int.tryParse(oldValue);
      int length = num ?? oldValue.length;
      if (name.length > length) return name.substring(0, num);
      return menu.fillPosition.isFront
          ? name.padLeft(length, newValue)
          : name.padRight(length, newValue);
    case ReplaceMode.position:
      int start = menu.start - 1, length = menu.length;
      int end = start + length;
      if (start + length > name.length) end = name.length;
      return name.replaceRange(start, end, newValue);
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
