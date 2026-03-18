import 'package:flutter/material.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/num.dart';
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

@riverpod
class ViewImageWidth extends _$ViewImageWidth {
  @override
  int build() =>
      StorageUtil.getInt(AppKeys.imageWidth) ?? AppNum.imageSizes.first;
  Future<void> update(bool left) async {
    List<int> list = AppNum.imageSizes;
    int index = list.indexOf(state);
    if (index == -1) {
      final tempList = List.from(list)
        ..add(state)
        ..sort();
      index = tempList.indexOf(state);
      if (index == 0) {
        index = -1;
      } else if (index != tempList.length - 1) {
        index = left ? index - 1 : index;
      }
    }
    if (!left) state = index > 0 ? list[index - 1] : state;
    if (left) state = index < list.length - 1 ? list[index + 1] : state;
    await StorageUtil.setInt(AppKeys.imageWidth, state);
  }

  Future<void> set(int value) async {
    state = value;
    await StorageUtil.setInt(AppKeys.imageWidth, state);
  }
}

@riverpod
class ConetentFocusNode extends _$ConetentFocusNode {
  @override
  FocusNode build() {
    final node = FocusNode();
    ref.onDispose(() => node.dispose());
    return node;
  }
}
