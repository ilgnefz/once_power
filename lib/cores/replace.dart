import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enums/match.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/utils/match.dart';

String replaceName(
  WidgetRef ref,
  String name,
  String match,
  String modify,
  bool isLen,
  bool caseSen,
) {
  if (match == '') return name;
  int start = 0, end = 0;
  if (isLen) (start, end) = getLenNum(match, name.length);
  List<ReplaceType> types = ref.watch(selectedReplaceTypeProvider);
  bool checkMatch = types.contains(ReplaceType.match);
  List<String> matchText = match.trim().split(' ');
  bool isDigit = matchText.every((e) => int.tryParse(e) != null);
  bool oneNum = isDigit && matchText.length == 1;
  if (caseSen) {
    name = name.toLowerCase();
    match = match.toLowerCase();
  }
  // 匹配的
  if (types.length == 1 && checkMatch) {
    if (isLen) {
      String front = name.substring(0, start);
      String back = name.substring(end);
      name = front + modify + back;
    } else {
      name = regexReplace(name, match, modify, caseSen);
    }
  }
  // 之前的
  if (types.contains(ReplaceType.before)) {
    if (isLen) {
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
      int index = name.lastIndexOf(match);
      if (index != -1) {
        if (checkMatch) index += match.length;
        name = modify + name.substring(index);
      }
    }
  }
  // 之后的
  if (types.contains(ReplaceType.after)) {
    if (isLen) {
      if (oneNum) end = int.parse(matchText.first) > 0 ? end : start + 1;
      if (checkMatch) end -= 1;
      end = end > name.length ? name.length : end;
      end = end < 0 ? 0 : end;
      name = name.substring(0, end) + modify;
    }
    if (!isLen) {
      int index = name.indexOf(match);
      if (index != -1) {
        if (checkMatch) index -= match.length;
        name = name.substring(0, index + match.length) + modify;
      }
    }
  }
  // 中间的
  if (types.contains(ReplaceType.between)) {
    if (isLen && !oneNum) {
      start = checkMatch ? start : start + 1;
      end = checkMatch ? end : end - 1;
      String front = name.substring(0, start);
      String back = name.substring(end);
      name = front + modify + back;
    }
    if (!isLen) {
      int index = name.indexOf(match);
      int lastIndex = name.lastIndexOf(match);
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
