import 'package:once_power/model/enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select.g.dart';

@riverpod
class CurrentMode extends _$CurrentMode {
  @override
  FunctionMode build() => FunctionMode.replace;
  void update(FunctionMode mode) => state = mode;
}

@riverpod
class InputLength extends _$InputLength {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class MatchCase extends _$MatchCase {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class DateRename extends _$DateRename {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class CyclePrefix extends _$CyclePrefix {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class CycleSuffix extends _$CycleSuffix {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class SwapPrefix extends _$SwapPrefix {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class SwapSuffix extends _$SwapSuffix {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class ModifyExtension extends _$ModifyExtension {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class AppendMode extends _$AppendMode {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class AddFolder extends _$AddFolder {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class CurrentDate extends _$CurrentDate {
  @override
  DateTime build() => DateTime.now();
  void update(DateTime date) => state = date;
}

@riverpod
class CurrentTime extends _$CurrentTime {
  @override
  DateTime build() => DateTime.now();
  void update(DateTime date) => state = date;
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

@riverpod
class Cancel extends _$Cancel {
  @override
  bool build() => false;
  void update() => state = !state;
}
