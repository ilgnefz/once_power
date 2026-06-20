import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/model/date.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/src/rust/api/models.dart';

void autoMatchInput(WidgetRef ref, String name) {
  if (ref.watch(currentModeProvider).isReserve) {
    ref.read(modifyControllerProvider).clear();
  }
  ref.read(matchControllerProvider.notifier).update(name);
  updateName(ref);
}

void autoModifyInput(WidgetRef ref, String name) {
  if (ref.watch(currentModeProvider).isReserve) {
    ref.read(matchControllerProvider).clear();
  }
  ref.read(modifyControllerProvider.notifier).update(name);
  updateName(ref);
}

// TODO: file.created 可能为 Null
void autoMatchCreateInput(WidgetRef ref, FileInfo file) {
  DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
  ref
      .read(fileDatePropertyProvider.notifier)
      .update(
        dateProperty.copyWith(createdDate: file.created?.date.toString()),
      );
}

void autoMatchModifyInput(WidgetRef ref, FileInfo file) {
  DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
  ref
      .read(fileDatePropertyProvider.notifier)
      .update(
        dateProperty.copyWith(modifiedDate: file.modified?.date.toString()),
      );
}

void autoMatchAccessInput(WidgetRef ref, FileInfo file) {
  DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
  ref
      .read(fileDatePropertyProvider.notifier)
      .update(
        dateProperty.copyWith(accessedDate: file.accessed?.date.toString()),
      );
}

void autoMatchDateInput(WidgetRef ref, FileInfo file) {
  DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
  ref
      .read(fileDatePropertyProvider.notifier)
      .update(
        dateProperty.copyWith(
          createdDate: file.created?.date.toString(),
          modifiedDate: file.modified?.date.toString(),
          accessedDate: file.accessed?.date.toString(),
        ),
      );
}
