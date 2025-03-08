import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/models/two_re_enum.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/utils/match.dart';

String reserveModeName(WidgetRef ref, String name) {
  String match = ref.watch(matchControllerProvider).text;
  String modify = ref.watch(modifyControllerProvider).text;
  bool matchCase = ref.watch(isCaseSensitiveProvider);
  bool isLength = ref.watch(isInputLengthProvider);
  List<ReserveType> typeList = ref.watch(currentReserveTypeProvider);
  if (isLength) {
    int start = 0, end = 0;
    (start, end) = getLenNum(match, name.length);
    return name.substring(start, end);
  }
  if (typeList.isEmpty) name = getMatchedStrings(match, name, matchCase);
  if (typeList.isNotEmpty) name = reserveTypeString(typeList, name).trim();
  if (modify != '') name = modify;
  return name;
}
