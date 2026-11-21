import 'dart:async';

import 'package:once_power/constant/key.dart';
import 'package:once_power/enmu/app.dart';
import 'package:once_power/enmu/date.dart';
import 'package:once_power/service/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'switch.g.dart';

@riverpod
class CurrentMode extends _$CurrentMode {
  @override
  FunctionMode build() =>
      FunctionMode.values[StorageService.getInt(AppKeys.mode) ?? 0];

  void update(FunctionMode value) {
    state = value;
    int index = FunctionMode.values.indexOf(value);
    unawaited(StorageService.setInt(AppKeys.mode, index));
  }
}

@riverpod
class CurrentDate extends _$CurrentDate {
  @override
  DateType build() => DateType.values[StorageService.getInt(AppKeys.date) ?? 0];

  void update(DateType value) {
    state = value;
    int index = DateType.values.indexOf(value);
    unawaited(StorageService.setInt(AppKeys.date, index));
  }
}

@riverpod
class CurrentTheme extends _$CurrentTheme {
  @override
  ThemeType build() =>
      ThemeType.values[StorageService.getInt(AppKeys.theme) ?? 0];

  void update(ThemeType value) {
    state = value;
    int index = ThemeType.values.indexOf(value);
    unawaited(StorageService.setInt(AppKeys.theme, index));
  }
}
