import 'package:once_power/model/enum.dart';
import 'package:path/path.dart' as path;

String formatDateTime(DateTime dateTime) {
  String formattedDateTime = '${dateTime.year}'
      '${dateTime.month.toString().padLeft(2, '0')}'
      '${dateTime.day.toString().padLeft(2, '0')}'
      '${dateTime.hour.toString().padLeft(2, '0')}'
      '${dateTime.minute.toString().padLeft(2, '0')}'
      '${dateTime.second.toString().padLeft(2, '0')}';
  return formattedDateTime;
}

String formatNumber(int n, int width) {
  if (width == 0) return '';
  return n.toString().padLeft(width, '0');
}

DateTime formatExifDate(String date) {
  List<String> list = date.split(' ');
  String ymd = list.first.replaceAll(':', '-');
  list.replaceRange(0, 1, [ymd]);
  return DateTime.parse(list.join(' '));
}

int getVersionNumber(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 10000 + versionCells[1] * 100 + versionCells[2];
}

int getNum(String value) {
  RegExp exp = RegExp(r'\d+');
  RegExpMatch? match = exp.firstMatch(value);
  if (match != null) return int.parse(match.group(0)!);
  return 0;
}

String getFileName(String name, String extension) {
  if (extension == '' || extension == 'dir') return name;
  return '$name.$extension';
}

String regexReplace(
    String text, String pattern, String replacement, bool caseSensitive) {
  RegExp regExp;
  pattern = addEscapeIfPunctuation(pattern);
  if (caseSensitive) {
    regExp = RegExp(pattern);
  } else {
    regExp = RegExp(pattern, caseSensitive: false);
  }
  return text.replaceAll(regExp, replacement);
}

String getMatchedStrings(String pattern, String input, bool matchCase) {
  // 创建正则表达式，设置为不区分大小写
  pattern = addEscapeIfPunctuation(pattern);
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

String addEscapeIfPunctuation(String text) {
  final punctuations = [
    '.',
    ',',
    ';',
    ':',
    '!',
    '?',
    '(',
    ')',
    '[',
    ']',
    '{',
    '}'
  ];
  String result = '';
  for (int i = 0; i < text.length; i++) {
    final char = text[i];
    if (punctuations.contains(char)) {
      result += '\\$char';
    } else {
      result += char;
    }
  }
  return result;
}

String getFolderName(String folder) => path.basename(folder);
