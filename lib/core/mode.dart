import 'dart:math';

import 'package:once_power/model/enum.dart';
import 'package:once_power/utils/format.dart';

(int, int) lengthMatchNum(String match, String name) {
  int start = 0, end = 0;
  List<String> matchText = match.trim().split(' ');
  bool isDigit = matchText.every((e) => int.tryParse(e) != null);
  if (isDigit) {
    if (matchText.length == 1) {
      int first = int.parse(matchText.first);
      if (first > 0) end = first;
      if (first < 0) {
        start = name.length + first;
        end = name.length;
      }
    } else if (matchText.length > 1) {
      int first = int.parse(matchText.first);
      int last = int.parse(matchText.last);
      if (first > 0) start = first - 1;
      if (last > 0) end = last;
      if (first < 0) start = name.length + first;
      if (last < 0) end = name.length + last + 1;
    }
    start = start > name.length - 1 ? name.length - 1 : start;
    end = end > name.length ? name.length : end;
    if (end < start) start = 0;
  } else {
    end = match.length > name.length ? name.length : match.length;
  }
  return (start < 0 ? 0 : start, end < 0 ? 0 : end);
}

/// 替换模式
String replaceName(List<ReplaceType> types, String match, String modify,
    String name, bool isLength, bool matchCase) {
  int start = 0, end = 0;
  if (isLength) (start, end) = lengthMatchNum(match, name);
  bool checkMatch = types.contains(ReplaceType.match);
  List<String> matchText = match.trim().split(' ');
  bool isDigit = matchText.every((e) => int.tryParse(e) != null);
  bool oneNum = isDigit && matchText.length == 1;
  // 匹配的
  if (types.length == 1 && types.contains(ReplaceType.match) && match != '') {
    if (isLength) {
      String front = name.substring(0, start);
      String back = name.substring(end);
      name = front + modify + back;
    } else {
      name = regexReplace(name, match, modify, matchCase);
    }
  }
  // 之前的
  if (types.contains(ReplaceType.before) && match != '') {
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
  if (types.contains(ReplaceType.after) && match != '') {
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
  if (types.contains(ReplaceType.middle) && match != '') {
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

/// 保留模式
String reserveName(List<ReserveType> typeList, String match, String modify,
    String name, bool isLength, bool matchCase) {
  if (isLength) {
    int start = 0, end = 0;
    (start, end) = lengthMatchNum(match, name);
    return name.substring(start, end);
  }
  if (typeList.isEmpty) name = getMatchedStrings(match, name, matchCase);
  if (typeList.isNotEmpty) name = reserveTypeString(typeList, name);
  if (modify != '') name = modify;
  return name;
}
