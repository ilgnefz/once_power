import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/toggle.dart';

(int, int) lengthMatchNum(String match, String name) {
  int start = 0, end = 0;
  bool isDigit = int.tryParse(match.replaceAll(' ', '')) != null;
  if (isDigit) {
    bool hasSpace = match.trim().contains(' ');
    start = hasSpace ? int.parse(match.split(' ').first) - 1 : 0;
    start = start > name.length - 1 ? name.length - 1 : start;
    end = hasSpace ? int.parse(match.split(' ').last) : int.parse(match);
    end = end > name.length ? name.length : end;
    if (end < start) {
      start = 0;
      end = 0;
    }
  } else {
    end = match.length > name.length ? name.length : match.length;
  }
  return (start < 0 ? 0 : start, end < 0 ? 0 : end);
}

/// 替换模式
String replaceName(RemoveType type, String match, String modify, String name,
    bool isLength, bool matchCase, String? dateText) {
  int start = 0, end = 0;
  if (isLength) (start, end) = lengthMatchNum(match, name);
  modify = dateText ?? modify;

  // 匹配的
  if (type == RemoveType.match) {
    if (isLength) {
      String front = name.substring(0, start);
      String back = name.substring(end);
      name = front + modify + back;
    }
    if (!isLength) {
      if (matchCase) name = name.replaceAll(match, modify);
      // 不区分大小写时情况很多
      if (!matchCase && match != '') {
        int index = name.toLowerCase().indexOf(match.toLowerCase());
        while (index != -1) {
          name = name.substring(0, index) +
              modify +
              name.substring(index + match.length);
          index = name
              .toLowerCase()
              .indexOf(match.toLowerCase(), index + modify.length);
        }
      }
    }
  }
  // 之前的
  if (type == RemoveType.before) {
    if (isLength) name = name.substring(start);
    if (!isLength) {
      int index = matchCase
          ? name.lastIndexOf(match)
          : name.toLowerCase().lastIndexOf(match.toLowerCase());
      if (index != -1) name = modify + name.substring(index);
    }
  }
  // 之后的
  if (type == RemoveType.after) {
    if (isLength) name = name.substring(0, end);
    if (!isLength) {
      int index = matchCase
          ? name.indexOf(match)
          : name.toLowerCase().indexOf(match.toLowerCase());
      if (index != -1) name = name.substring(0, index + match.length) + modify;
    }
  }
  // 中间的
  if (type == RemoveType.middle) {
    if (isLength) {
      String front = name.substring(0, start + 1);
      String back =
          name.substring(end + 1 > name.length ? name.length : end + 1);
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
        String front = name.substring(0, index + match.length);
        String back = name.substring(lastIndex);
        name = front + modify + back;
      }
    }
  }
  return name;
}

/// 保留模式
String reserveName(WidgetRef ref, String match, String modify, String name,
    bool isLength, bool matchCase, String? dateText) {
  List<ReserveType> typeList = ref.watch(currentReserveTypeProvider);
  int start = 0, end = 0;
  if (isLength && match != '') {
    (start, end) = lengthMatchNum(match, name);
    return name.substring(start, end);
  }
  modify = dateText ?? modify;
  if (match != '') {
    if (!isLength) name = getMatchedStrings(match, name, matchCase);
    if (isLength) {
      var (start, end) = lengthMatchNum(match, name);
      name = name.substring(start, end);
    }
  }
  if (typeList.isNotEmpty) name = reserveTypeString(typeList, name);
  if (typeList.isEmpty && match == '') name = modify;
  return name;
}

String getMatchedStrings(String pattern, String input, bool matchCase) {
  // 创建正则表达式，设置为不区分大小写
  RegExp regex = RegExp(pattern, caseSensitive: matchCase);
  // 使用allMatches方法获取所有匹配的字符串
  Iterable<Match> matches = regex.allMatches(input);
  // 从匹配中提取字符串并返回
  List<String?> matchedStrings = matches.map((m) => m.group(0)).toList();
  return matchedStrings.isEmpty ? '' : matchedStrings.join('');
}

String reserveTypeString(List<ReserveType> typeList, String name) {
  bool lowercase = typeList.contains(ReserveType.lowercaseLetter);
  bool capital = typeList.contains(ReserveType.capitalLetter);
  bool digit = typeList.contains(ReserveType.digit);
  bool nonLetter = typeList.contains(ReserveType.nonLetter);
  bool punctuation = typeList.contains(ReserveType.punctuation);
  String pattern = "";
  if (!lowercase) pattern += "a-z";
  if (!capital) pattern += "A-Z";
  if (!digit) pattern += "0-9";
  if (!nonLetter) {
    // 中文、日文、朝鲜文、藏文
    pattern +=
        r"\u4e00-\u9fff\u3040-\u309f\u30a0-\u30ff\uac00-\ud7af\u0f00-\u0fff";
  }
  if (!punctuation) {
    pattern += r"()\~!@#\$%\^&,'\.;_\[\]`\{\}\-=+！，。？：、‘’“”（）【】{}<>《》「」";
  }
  RegExp reg = RegExp("[$pattern]");
  return name.replaceAll(reg, "");
}
