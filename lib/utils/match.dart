import 'package:once_power/enums/match.dart';

String regexReplace(
  String text,
  String pattern,
  String replacement,
  bool caseSensitive,
) {
  final RegExp regExp = RegExp(
    addEscapeIfPunctuation(pattern),
    caseSensitive: caseSensitive,
  );
  return text.replaceAll(regExp, replacement);
}

String addEscapeIfPunctuation(String text) {
  Set<String> punctuations = {
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
    '}',
  };
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

String getMatchedStrings(String pattern, String input, bool matchCase) {
  pattern = addEscapeIfPunctuation(pattern);
  RegExp regex = RegExp(pattern, caseSensitive: matchCase);
  Iterable<Match> matches = regex.allMatches(input);
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
