import 'package:once_power/const/key.dart';
import 'package:once_power/model/date.dart';
import 'package:once_power/util/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'value.g.dart';

@riverpod
class DateDigit extends _$DateDigit {
  @override
  int build() => 8;

  void update(int value) => state = value;
}

@riverpod
class PrefixDigit extends _$PrefixDigit {
  @override
  int build() => 0;

  void update(int value) => state = value;
}

@riverpod
class PrefixStart extends _$PrefixStart {
  @override
  int build() => 0;

  void update(int value) => state = value;
}

@riverpod
class SuffixDigit extends _$SuffixDigit {
  @override
  int build() => 0;

  void update(int value) => state = value;
}

@riverpod
class SuffixStart extends _$SuffixStart {
  @override
  int build() => 0;

  void update(int value) => state = value;
}

@riverpod
class CSVNameColumn extends _$CSVNameColumn {
  @override
  String build() => 'A';
  void update(String value) => state = value;
}

@riverpod
class FileDateProperty extends _$FileDateProperty {
  @override
  DateProperty build() => DateProperty();
  void update(DateProperty value) => state = value;
}

@riverpod
class CurrentPresetName extends _$CurrentPresetName {
  @override
  String build() => StorageUtil.getString(AppKeys.currentPresetName) ?? '';
  Future<void> update(String value) async {
    state = value;
    await StorageUtil.setString(AppKeys.currentPresetName, value);
  }
}
