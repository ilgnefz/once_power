import 'package:flutter/material.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/utils/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'value.g.dart';

@riverpod
class DateLengthValue extends _$DateLengthValue {
  @override
  int build() => 8;
  void update(int value) => state = value;
}

// @riverpod
// class PrefixFileName extends _$PrefixFileName {
//   @override
//   String? build() => null;
//   void update(String value) => state = value;
//   void clear() => state = null;
// }
//
// @riverpod
// class PrefixFileContent extends _$PrefixFileContent {
//   @override
//   String? build() => null;
//   void update(String value) => state = value;
//   void clear() => state = null;
// }

@riverpod
class PrefixSerialLength extends _$PrefixSerialLength {
  @override
  int build() => StorageUtil.getInt(AppKeys.prefixSerialLength) ?? 0;
  Future<void> update(int value) async {
    state = value;
    StorageUtil.setInt(AppKeys.prefixSerialLength, value);
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

// @riverpod
// class SuffixFileName extends _$SuffixFileName {
//   @override
//   String? build() => null;
//   void update(String value) => state = value;
//   void clear() => state = null;
// }

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
