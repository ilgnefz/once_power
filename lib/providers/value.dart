import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/models/date_preporty.dart';
import 'package:once_power/utils/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'value.g.dart';

@riverpod
class DateLengthValue extends _$DateLengthValue {
  @override
  int build() => 8;
  void update(int value) => state = value;
}

@riverpod
class PrefixSerialLength extends _$PrefixSerialLength {
  @override
  int build() => StorageUtil.getInt(AppKeys.prefixSerialLength) ?? 0;
  Future<void> update(int value) async {
    state = value;
    await StorageUtil.setInt(AppKeys.prefixSerialLength, value);
  }
}

@riverpod
class PrefixSerialStart extends _$PrefixSerialStart {
  @override
  int build() => StorageUtil.getInt(AppKeys.prefixSerialStart) ?? 0;
  Future<void> update(int value) async {
    state = value;
    StorageUtil.setInt(AppKeys.prefixSerialStart, value);
  }
}

@riverpod
class SuffixSerialLength extends _$SuffixSerialLength {
  @override
  int build() => StorageUtil.getInt(AppKeys.suffixSerialLength) ?? 0;
  Future<void> update(int value) async {
    state = value;
    StorageUtil.setInt(AppKeys.suffixSerialLength, value);
  }
}

@riverpod
class SuffixSerialStart extends _$SuffixSerialStart {
  @override
  int build() => StorageUtil.getInt(AppKeys.suffixSerialStart) ?? 0;
  Future<void> update(int value) async {
    state = value;
    StorageUtil.setInt(AppKeys.suffixSerialStart, value);
  }
}

@riverpod
class ScrollBarController extends _$ScrollBarController {
  @override
  ScrollController build() {
    ScrollController controller = ScrollController();
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  }
}

@riverpod
class CSVNameColumn extends _$CSVNameColumn {
  @override
  String build() => 'A';
  void update(String value) => state = value;
}

@riverpod
class ViewImageWidth extends _$ViewImageWidth {
  @override
  double build() => StorageUtil.getDouble(AppKeys.viewImageW) ?? AppNum.imageW;
  Future<void> update(bool left) async {
    // List<double> list = [136, 141, 156, 171, 229, 346, 696];
    List<double> list = AppNum.imageSizes;
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
    await StorageUtil.setDouble(AppKeys.viewImageW, state);
  }

  Future<void> set(double value) async {
    state = value;
    await StorageUtil.setDouble(AppKeys.viewImageW, state);
  }
}

@riverpod
class FileDateProperty extends _$FileDateProperty {
  @override
  DateProperty build() => DateProperty();

  void update(DateProperty value) => state = value;
}
