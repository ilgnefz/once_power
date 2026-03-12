import 'package:once_power/const/key.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/match.dart';
import 'package:once_power/enum/organize.dart';
import 'package:once_power/enum/sort.dart';
import 'package:once_power/util/storage.dart';
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

// ----- Organize -----
@riverpod
class OrganizeDate extends _$OrganizeDate {
  @override
  DateType build() {
    int index = StorageUtil.getInt(AppKeys.organizeDate) ?? 0;
    return DateType.values[index];
  }

  Future<void> update(DateType type) async {
    state = type;
    await StorageUtil.setInt(AppKeys.organizeDate, type.index);
  }
}

@riverpod
class OrganizeDateFormat extends _$OrganizeDateFormat {
  @override
  DateFormat build() {
    int index = StorageUtil.getInt(AppKeys.organizeDateFormat) ?? 0;
    return DateFormat.values[index];
  }

  Future<void> update(DateFormat value) async {
    state = value;
    await StorageUtil.setInt(AppKeys.organizeDateFormat, value.index);
  }
}

@riverpod
class OrganizeDateSeparate extends _$OrganizeDateSeparate {
  @override
  DateFormatSeparate build() {
    int index = StorageUtil.getInt(AppKeys.organizeDateSeparate) ?? 0;
    return DateFormatSeparate.values[index];
  }

  Future<void> update(DateFormatSeparate value) async {
    state = value;
    await StorageUtil.setInt(AppKeys.organizeDateSeparate, value.index);
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
