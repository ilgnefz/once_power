import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'input.g.dart';

@riverpod
class MatchController extends _$MatchController {
  @override
  TextEditingController build() {
    TextEditingController controller = TextEditingController();
    ref.onDispose(() => controller.dispose());
    return controller;
  }
}

@riverpod
class ModifyController extends _$ModifyController {
  @override
  TextEditingController build() {
    TextEditingController controller = TextEditingController();
    ref.onDispose(() => controller.dispose());
    return controller;
  }

  void update(String value) => state.text = value;
}

@riverpod
class PrefixController extends _$PrefixController {
  @override
  TextEditingController build() {
    TextEditingController controller = TextEditingController();
    ref.onDispose(() => controller.dispose());
    return controller;
  }
}

@riverpod
class SuffixController extends _$SuffixController {
  @override
  TextEditingController build() {
    TextEditingController controller = TextEditingController();
    ref.onDispose(() => controller.dispose());
    return controller;
  }
}

@riverpod
class ExtensionController extends _$ExtensionController {
  @override
  TextEditingController build() {
    TextEditingController controller = TextEditingController();
    ref.onDispose(() => controller.dispose());
    return controller;
  }
}
