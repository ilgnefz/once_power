import 'dart:typed_data';

import 'package:once_power/constants/keys.dart';
import 'package:once_power/utils/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme.g.dart';

@riverpod
class TranslucentInput extends _$TranslucentInput {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isTranslucentInput);
  Future<void> update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.isTranslucentInput, value);
  }
}

@riverpod
class TranslucentBtn extends _$TranslucentBtn {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isTranslucentBtn);
  Future<void> update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.isTranslucentBtn, value);
  }
}

@riverpod
class TransparentDivider extends _$TransparentDivider {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isTransparentDivider);
  Future<void> update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.isTransparentDivider, value);
  }
}

@riverpod
class BackgroundImage extends _$BackgroundImage {
  @override
  Uint8List? build() => StorageUtil.getUint8List(AppKeys.backgroundImage);
  Future<void> update(Uint8List value) async {
    state = value;
    await StorageUtil.setUint8List(AppKeys.backgroundImage, value);
  }

  void reset() {
    state = null;
    StorageUtil.remove(AppKeys.backgroundImage);
  }
}

@riverpod
class BackgroundOpacity extends _$BackgroundOpacity {
  @override
  double build() => StorageUtil.getDouble(AppKeys.backgroundOpacity) ?? .8;
  Future<void> update(double value) async {
    state = value;
    await StorageUtil.setDouble(AppKeys.backgroundOpacity, value);
  }

  void reset() {
    state = 1;
    StorageUtil.remove(AppKeys.backgroundOpacity);
  }
}
