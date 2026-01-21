import 'package:once_power/const/key.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/util/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme.g.dart';

@riverpod
class CurrentTheme extends _$CurrentTheme {
  @override
  ThemeType build() => ThemeType.values[StorageUtil.getInt(AppKeys.theme) ?? 0];
  Future<void> update() async {
    int index = state.index == 2 ? 0 : state.index + 1;
    state = ThemeType.values[index];
    await StorageUtil.setInt(AppKeys.theme, index);
  }
}
