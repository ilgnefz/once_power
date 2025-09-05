import 'package:once_power/constants/keys.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/enums/match.dart';
import 'package:once_power/enums/sort.dart';
import 'package:once_power/utils/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select.g.dart';

// ----- Action -----

@riverpod
class CurrentMode extends _$CurrentMode {
  @override
  FunctionMode build() {
    int index = StorageUtil.getInt(AppKeys.functionMode) ?? 0;
    return FunctionMode.values[index];
  }

  Future<void> update(FunctionMode mode) async {
    state = mode;
    await StorageUtil.setInt(AppKeys.functionMode, mode.index);
  }
}

@riverpod
class SelectedReplaceType extends _$SelectedReplaceType {
  @override
  List<ReplaceType> build() => [ReplaceType.match];
  void update(ReplaceType type) {
    if (state.contains(type)) {
      if (state.length == 1) return;
      state = state.where((e) => e != type).toList();
    } else {
      if (state.length == 1) {
        state = type == ReplaceType.match || state.contains(ReplaceType.match)
            ? [...state, type]
            : [type];
      } else if (state.length > 1) {
        state = [ReplaceType.match, type];
      }
    }
  }
}

@riverpod
class SelectedReserveType extends _$SelectedReserveType {
  @override
  List<ReserveType> build() => [];
  void update(ReserveType type) => state.contains(type)
      ? state = state.where((e) => e != type).toList()
      : state = [...state, type];
  void clear() => state = [];
}

@riverpod
class CurrentDateType extends _$CurrentDateType {
  @override
  DateType build() {
    int index = StorageUtil.getInt(AppKeys.dateType) ?? 0;
    return DateType.values[index];
  }

  Future<void> update(DateType type) async {
    state = type;
    await StorageUtil.setInt(AppKeys.dateType, type.index);
  }
}

// ----- Content -----

@riverpod
class CurrentSort extends _$CurrentSort {
  @override
  SortType build() {
    int index = StorageUtil.getInt(AppKeys.sortType) ?? 0;
    return SortType.values[index];
  }

  void update(SortType type) async {
    state = type;
    await StorageUtil.setInt(AppKeys.sortType, type.index);
  }
}

// ----- Bottom -----
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
