import 'package:once_power/model/enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toggle.g.dart';

@riverpod
class CurrentMode extends _$CurrentMode {
  @override
  FunctionMode build() => FunctionMode.replace;
  void update(FunctionMode mode) => state = mode;
}

@riverpod
class CurrentDateType extends _$CurrentDateType {
  @override
  DateType build() => DateType.createDate;
  void update(DateType type) => state = type;
}

@riverpod
class CurrentReserveType extends _$CurrentReserveType {
  @override
  List<ReserveType> build() => [];
  void update(ReserveType type) => state.contains(type)
      ? state = state.where((e) => e != type).toList()
      : state = [...state, type];
}

@riverpod
class CurrentRemoveType extends _$CurrentRemoveType {
  @override
  RemoveType build() => RemoveType.match;
  void update(RemoveType type) => state = type;
}

@riverpod
class FileSortType extends _$FileSortType {
  @override
  SortType build() => SortType.defaultSort;
  void update(SortType type) => state = type;
}
