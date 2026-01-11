import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/models/date.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/value.dart';

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

void autoMatchCreateInput(WidgetRef ref, FileInfo file) {
  DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
  ref.read(fileDatePropertyProvider.notifier).update(dateProperty.copyWith(
        createdDate: file.createdDate.date.toString(),
      ));
}

void autoMatchModifyInput(WidgetRef ref, FileInfo file) {
  DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
  ref.read(fileDatePropertyProvider.notifier).update(dateProperty.copyWith(
        modifiedDate: file.modifiedDate.date.toString(),
      ));
}

void autoMatchAccessInput(WidgetRef ref, FileInfo file) {
  DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
  ref.read(fileDatePropertyProvider.notifier).update(dateProperty.copyWith(
        accessedDate: file.accessedDate.date.toString(),
      ));
}

void autoMatchDateInput(WidgetRef ref, FileInfo file) {
  DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
  ref.read(fileDatePropertyProvider.notifier).update(dateProperty.copyWith(
        createdDate: file.createdDate.date.toString(),
        modifiedDate: file.modifiedDate.date.toString(),
        accessedDate: file.accessedDate.date.toString(),
      ));
}
