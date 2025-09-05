import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/normal.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';

import 'advance.dart';
import 'csv.dart';

void updateName(WidgetRef ref) {
  if (ref.watch(cSVDataProvider).isNotEmpty) return csvDataRename(ref);
  FunctionMode mode = ref.watch(currentModeProvider);
  if (mode.isAdvance) return advanceUpdateName(ref);
  if (mode.isReplace) return normalUpdateName(ref, false);
  if (mode.isReserve) return normalUpdateName(ref, true);
}
