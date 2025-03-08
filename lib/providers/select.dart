import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/organize_function_enum.dart';
import 'package:once_power/models/sort_enum.dart';
import 'package:once_power/models/two_re_enum.dart';
import 'package:once_power/utils/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select.g.dart';

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
class CurrentReplaceType extends _$CurrentReplaceType {
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
class CurrentReserveType extends _$CurrentReserveType {
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
LanguageType currentLanguage(Ref ref) {
  Locale? locale = ref.watch(languageProvider);
  if (locale == const Locale('en', 'US')) return LanguageType.english;
  return LanguageType.chinese;
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
class CSVData extends _$CSVData {
  @override
  List<CsvRenameInfo> build() => [];
  void update(List<CsvRenameInfo> value) => state = value;
  void updateOne(int index, String flag, String value) =>
      state = state.map((e) {
        if (state.indexOf(e) == index) {
          flag == 'A' ? e.nameA = value : e.nameB = value;
        }
        return e;
      }).toList();
}

@riverpod
class CurrentReplaceMode extends _$CurrentReplaceMode {
  @override
  ReplaceMode build() => ReplaceMode.normal;
  void update(ReplaceMode value) => state = value;
}

// @riverpod
// class CurrentOrganizeFunction extends _$CurrentOrganizeFunction {
//   @override
//   OrganizeFunction build() {
//     return OrganizeFunction.none;
//   }
//
//   void update(OrganizeFunction value) => state = value;
// }

// @riverpod
// class CurrentCompletePosition extends _$CurrentCompletePosition {
//   @override
//   CompletePosition build() => CompletePosition.before;
//
//   void update(CompletePosition value) => state = value;
// }

/* Deprecated */
// @riverpod
// class CurrentClassifyFileType extends _$CurrentClassifyFileType {
//   @override
//   ClassifyFileType build() {
//     int index = StorageUtil.getInt(AppKeys.classifyType) ?? 0;
//     return ClassifyFileType.values[index];
//   }
//
//   Future<void> update(ClassifyFileType type) async {
//     state = type;
//     await StorageUtil.setInt(AppKeys.classifyType, type.index);
//   }
// }
