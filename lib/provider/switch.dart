import 'dart:async';

import 'package:once_power/constant/key.dart';
import 'package:once_power/enmu/app.dart';
import 'package:once_power/service/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'switch.g.dart';

@riverpod
class CurrentMode extends _$CurrentMode {
  @override
  FunctionMode build() => FunctionMode.replace;

  void update(FunctionMode value) => state = value;
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
