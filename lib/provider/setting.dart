import 'dart:typed_data';

import 'package:once_power/const/key.dart';
import 'package:once_power/model/setting.dart';
import 'package:once_power/util/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting.g.dart';

@riverpod
class ThemeSetting extends _$ThemeSetting {
  @override
  CustomTheme build() => StorageUtil.getCustomTheme(AppKeys.customTheme);

  void updateDivider(bool value) {
    state = state.copyWith(divider: value);
    StorageUtil.setCustomTheme(AppKeys.customTheme, state);
  }

  void updateShadow(bool value) {
    state = state.copyWith(shadow: value);
    StorageUtil.setCustomTheme(AppKeys.customTheme, state);
  }

  void updateAlpha(double value) {
    state = state.copyWith(alpha: value);
    StorageUtil.setCustomTheme(AppKeys.customTheme, state);
  }

  void updateSigma(double value) {
    state = state.copyWith(sigma: value);
    StorageUtil.setCustomTheme(AppKeys.customTheme, state);
  }

  void updateBackground(String value) {
    state = state.copyWith(background: value);
    StorageUtil.setCustomTheme(AppKeys.customTheme, state);
  }

  void updateBackgroundBytes(Uint8List? value) {
    state = state.copyWith(backgroundBytes: value);
    StorageUtil.setCustomTheme(AppKeys.customTheme, state);
  }
}
