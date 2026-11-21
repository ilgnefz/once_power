import 'dart:async';

import 'package:once_power/constant/key.dart';
import 'package:once_power/service/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'input.g.dart';

@riverpod
class Match extends _$Match {
  @override
  String build() => StorageService.getString(AppKeys.match) ?? '';

  void update(String value) {
    state = value;
    unawaited(StorageService.setString(AppKeys.match, value));
  }
}

@riverpod
class Modify extends _$Modify {
  @override
  String build() => StorageService.getString(AppKeys.modify) ?? '';

  void update(String value) {
    state = value;
    unawaited(StorageService.setString(AppKeys.modify, value));
  }
}

@riverpod
class DateDigits extends _$DateDigits {
  @override
  int build() => StorageService.getInt(AppKeys.dateDigits) ?? 8;

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.dateDigits, value));
  }
}

@riverpod
class Prefix extends _$Prefix {
  @override
  String build() => StorageService.getString(AppKeys.prefix) ?? '';

  void update(String value) {
    state = value;
    unawaited(StorageService.setString(AppKeys.prefix, value));
  }
}

@riverpod
class PrefixDigits extends _$PrefixDigits {
  @override
  int build() => StorageService.getInt(AppKeys.prefixDigits) ?? 0;

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.prefixDigits, value));
  }
}

@riverpod
class PrefixStart extends _$PrefixStart {
  @override
  int build() => StorageService.getInt(AppKeys.prefixStart) ?? 0;

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.prefixStart, value));
  }
}

@riverpod
class Suffix extends _$Suffix {
  @override
  String build() => StorageService.getString(AppKeys.suffix) ?? '';

  void update(String value) {
    state = value;
    unawaited(StorageService.setString(AppKeys.suffix, value));
  }
}

@riverpod
class SuffixDigits extends _$SuffixDigits {
  @override
  int build() => StorageService.getInt(AppKeys.suffixDigits) ?? 0;

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.suffixDigits, value));
  }
}

@riverpod
class SuffixStart extends _$SuffixStart {
  @override
  int build() => StorageService.getInt(AppKeys.suffixStart) ?? 0;

  void update(int value) {
    state = value;
    unawaited(StorageService.setInt(AppKeys.suffixStart, value));
  }
}

@riverpod
class Extension extends _$Extension {
  @override
  String build() => StorageService.getString(AppKeys.extension) ?? '';

  void update(String value) {
    state = value;
    unawaited(StorageService.setString(AppKeys.extension, value));
  }
}
