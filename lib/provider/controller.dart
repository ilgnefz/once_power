import 'package:flutter_multi_select_reorder/flutter_multi_select_reorder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controller.g.dart';

@riverpod
class SelectionController extends _$SelectionController {
  @override
  MultiSelectController build() {
    MultiSelectController controller = MultiSelectController();
    ref.onDispose(() => controller.dispose());
    return controller;
  }
}
