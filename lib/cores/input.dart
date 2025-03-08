import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/select.dart';

import 'rename.dart';

void autoMatchInput(WidgetRef ref, String name) {
  if (ref.watch(currentModeProvider) == FunctionMode.reserve) {
    ref.read(modifyControllerProvider).clear();
    // unselectDateName(ref);
  }
  // ref.read(matchControllerProvider.notifier).updateText(name);
  updateName(ref);
}

void autoModifyInput(WidgetRef ref, String name) {
  if (ref.watch(currentModeProvider) == FunctionMode.reserve) {
    ref.read(matchControllerProvider).clear();
  }
  // unselectDateName(ref);
  // ref.read(modifyControllerProvider.notifier).updateText(name);
  updateName(ref);
}
