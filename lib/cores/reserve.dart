import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enums/match.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/utils/match.dart';

String reserveName(
  WidgetRef ref,
  String name,
  String match,
  String modify,
  bool isLen,
  bool caseSen,
) {
  List<ReserveType> typeList = ref.watch(selectedReserveTypeProvider);
  if (isLen) {
    int start = 0, end = 0;
    (start, end) = getLenNum(match, name.length);
    return name.substring(start, end);
  }
  if (typeList.isEmpty) name = getMatchedStrings(match, name, caseSen);
  if (typeList.isNotEmpty) name = reserveTypeString(typeList, name).trim();
  if (modify != '') name = modify;
  return name;
}
