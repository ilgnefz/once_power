import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';

import 'update.dart';

void autoMatchInput(WidgetRef ref, String name) {
  if (ref.watch(currentModeProvider).isReserve) {
    ref.read(modifyControllerProvider).clear();
  }
  ref.read(matchControllerProvider.notifier).updateText(name);
  updateName(ref);
}

void autoModifyInput(WidgetRef ref, String name) {
  if (ref.watch(currentModeProvider).isReserve) {
    ref.read(matchControllerProvider).clear();
  }
  ref.read(modifyControllerProvider.notifier).updateText(name);
  updateName(ref);
}
