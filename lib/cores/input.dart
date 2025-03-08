import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/select.dart';

void autoMatchInput(WidgetRef ref, String name) {
  if (ref.watch(currentModeProvider) == FunctionMode.reserve) {
    ref.read(modifyControllerProvider).clear();
  }
  updateName(ref);
}

void autoModifyInput(WidgetRef ref, String name) {
  if (ref.watch(currentModeProvider) == FunctionMode.reserve) {
    ref.read(matchControllerProvider).clear();
  }
  updateName(ref);
}
