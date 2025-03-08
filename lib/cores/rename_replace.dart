import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/models/two_re_enum.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/utils.dart';

String replaceModeName(WidgetRef ref, String name, String modify) {
  String match = ref.watch(matchControllerProvider).text;

  bool matchCase = ref.watch(isCaseSensitiveProvider);
  List<ReplaceType> types = ref.watch(currentReplaceTypeProvider);
  bool isLength = ref.watch(isInputLengthProvider);
  int start = 0, end = 0;
  if (isLength) (start, end) = getLenNum(match, name.length);
  bool checkMatch = types.contains(ReplaceType.match);
  List<String> matchText = match.trim().split(' ');
  bool isDigit = matchText.every((e) => int.tryParse(e) != null);
  bool oneNum = isDigit && matchText.length == 1;
  // 匹配的
  if (match == '') return name;
  if (types.length == 1 && types.contains(ReplaceType.match)) {
    if (isLength) {
      String front = name.substring(0, start);
      String back = name.substring(end);
      name = front + modify + back;
    } else {
      name = regexReplace(name, match, modify, matchCase);
    }
  }
  // 之前的
  if (types.contains(ReplaceType.before)) {
    if (isLength) {
      if (oneNum) {
        end = int.parse(matchText.first) > 0 ? end : start;
        if (checkMatch) end += 1;
      } else {
        end = checkMatch ? max(start, end) : max(start, end) - 1;
      }
      end = end > name.length ? name.length : end;
      end = end < 0 ? 0 : end;
      name = modify + name.substring(end);
    } else {
      int index = matchCase
          ? name.lastIndexOf(match)
          : name.toLowerCase().lastIndexOf(match.toLowerCase());
      if (index != -1) {
        if (checkMatch) index += match.length;
        name = modify + name.substring(index);
      }
    }
  }
  // 之后的
  if (types.contains(ReplaceType.after)) {
    if (isLength) {
      if (oneNum) end = int.parse(matchText.first) > 0 ? end : start + 1;
      if (checkMatch) end -= 1;
      end = end > name.length ? name.length : end;
      end = end < 0 ? 0 : end;
      name = name.substring(0, end) + modify;
    }
    if (!isLength) {
      int index = matchCase
          ? name.indexOf(match)
          : name.toLowerCase().indexOf(match.toLowerCase());
      if (index != -1) {
        if (checkMatch) index -= match.length;
        name = name.substring(0, index + match.length) + modify;
      }
    }
  }
  // 中间的
  if (types.contains(ReplaceType.between)) {
    if (isLength && !oneNum) {
      start = checkMatch ? start : start + 1;
      end = checkMatch ? end : end - 1;
      String front = name.substring(0, start);
      String back = name.substring(end);
      name = front + modify + back;
    }
    if (!isLength) {
      int index = matchCase
          ? name.indexOf(match)
          : name.toLowerCase().indexOf(match.toLowerCase());
      int lastIndex = matchCase
          ? name.lastIndexOf(match)
          : name.toLowerCase().lastIndexOf(match.toLowerCase());
      if (index != -1 && index != lastIndex) {
        if (checkMatch) index -= 1;
        if (checkMatch) lastIndex += 1;
        String front = name.substring(0, index + match.length);
        String back = name.substring(lastIndex);
        name = front + modify + back;
      }
    }
  }
  return name;
}
