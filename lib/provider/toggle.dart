import 'dart:io';
import 'dart:ui';

import 'package:once_power/constants/keys.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/utils/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toggle.g.dart';

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

@riverpod
class CurrentReserveType extends _$CurrentReserveType {
  @override
  List<ReserveType> build() => [];
  void update(ReserveType type) => state.contains(type)
      ? state = state.where((e) => e != type).toList()
      : state = [...state, type];
  void clear() => state = [];
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
  SortType build() {
    int index = StorageUtil.getInt(AppKeys.sortType) ?? 0;
    return SortType.values[index];
  }

  void update(SortType type) async {
    state = type;
    await StorageUtil.setInt(AppKeys.sortType, type.index);
  }
}

@riverpod
class Language extends _$Language {
  @override
  Locale? build() => StorageUtil.getLocale(AppKeys.locale);

  void update(Locale? locale) {
    if (locale != null) StorageUtil.setLocale(AppKeys.locale, locale);
    if (locale == null) StorageUtil.remove(AppKeys.locale);
    state = locale;
    S.load(state ?? Locale(Platform.localeName));
  }
}

@riverpod
LanguageType currentLanguage(CurrentLanguageRef ref) {
  Locale? locale = ref.watch(languageProvider);
  if (locale == const Locale('en', 'US')) return LanguageType.english;
  return LanguageType.chinese;
}

@riverpod
class OriginNameColumn extends _$OriginNameColumn {
  @override
  int build() => 0;
  void update(int value) => state = value;
}
