import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/advance.dart';

import 'advance.dart';

String advanceDeleteName(AdvanceMenuDelete menu, String name) {
  if (menu.useRegex) return name.replaceAll(RegExp(menu.value), '');
  switch (menu.mode) {
    case DeleteMode.input:
      return changeMatch(
        menu.matchContent,
        name,
        menu.value,
        '',
        menu.number,
        menu.front,
        menu.behind,
      );
    case DeleteMode.type:
      Set<DeleteType> types = menu.deleteTypes.toSet();
      if (types.contains(DeleteType.digit)) {
        name = name.replaceAll(RegExp(r'[0-9]'), '');
      }
      if (types.contains(DeleteType.capital)) {
        name = name.replaceAll(RegExp(r'[A-Z]'), '');
      }
      if (types.contains(DeleteType.lowercase)) {
        name = name.replaceAll(RegExp(r'[a-z]'), '');
      }
      if (types.contains(DeleteType.nonLetter)) {
        String pattern =
            r'\u4e00-\u9fff\u3040-\u309f\u30a0-\u30ff\uac00-\ud7af\u0f00-\u0fff';
        name = name.replaceAll(RegExp("[$pattern]"), '');
      }
      if (types.contains(DeleteType.punctuation)) {
        String pattern =
            r"()\~!@#\$%\^&,'\.;_\[\]`\{\}\-—=+！，。？：、‘’“”（）【】{}<>《》「」·`";
        name = name.replaceAll(RegExp("[$pattern]"), '');
      }
      if (types.contains(DeleteType.space)) name = name.replaceAll(' ', '');
      return name;
    case DeleteMode.position:
      int start = menu.start - 1, length = menu.length;
      int end = start + length;
      if (start + length > name.length) end = name.length;
      return name.replaceRange(start, end, '');
    default:
      return name;
  }
}
