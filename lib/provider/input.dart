import 'package:flutter/material.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'input.g.dart';

@riverpod
class MatchController extends _$MatchController {
  @override
  TextEditingController build() {
    TextEditingController controller = TextEditingController();
    controller.addListener(() {
      ref.read(matchClearProvider.notifier).update(controller.text.isNotEmpty);
      ref.read(currentReserveTypeProvider.notifier).clear();
    });
    return controller;
  }
}

@riverpod
class MatchClear extends _$MatchClear {
  @override
  bool build() => false;
  void update(bool value) => state = value;
}

@riverpod
class ModifyController extends _$ModifyController {
  @override
  TextEditingController build() {
    TextEditingController controller = TextEditingController();
    controller.addListener(() {
      ref.read(modifyClearProvider.notifier).update(controller.text.isNotEmpty);
    });
    return controller;
  }
}

@riverpod
class ModifyClear extends _$ModifyClear {
  @override
  bool build() => false;
  void update(bool value) => state = value;
}

@riverpod
class DateLengthController extends _$DateLengthController {
  @override
  TextEditingController build() {
    int text = StorageUtil.getInt(AppKeys.dateLength) ?? 8;
    return TextEditingController(text: '$text位');
  }
}

@riverpod
class PrefixController extends _$PrefixController {
  @override
  TextEditingController build() {
    TextEditingController controller = TextEditingController();
    controller.addListener(() {
      ref.read(prefixClearProvider.notifier).update(controller.text.isNotEmpty);
    });
    return controller;
  }
}

@riverpod
class PrefixClear extends _$PrefixClear {
  @override
  bool build() => false;
  void update(bool value) => state = value;
}

@riverpod
class PrefixLengthController extends _$PrefixLengthController {
  @override
  TextEditingController build() {
    int text = StorageUtil.getInt(AppKeys.prefixLength) ?? 0;
    return TextEditingController(text: '$text位');
  }
}

@riverpod
class PrefixStartController extends _$PrefixStartController {
  @override
  TextEditingController build() {
    int text = StorageUtil.getInt(AppKeys.prefixStart) ?? 0;
    return TextEditingController(text: '$text开始');
  }
}

@riverpod
class SuffixController extends _$SuffixController {
  @override
  TextEditingController build() {
    TextEditingController controller = TextEditingController();
    controller.addListener(() {
      ref.read(suffixClearProvider.notifier).update(controller.text.isNotEmpty);
    });
    return controller;
  }
}

@riverpod
class SuffixClear extends _$SuffixClear {
  @override
  bool build() => false;
  void update(bool value) => state = value;
}

@riverpod
class SuffixLengthController extends _$SuffixLengthController {
  @override
  TextEditingController build() {
    int text = StorageUtil.getInt(AppKeys.suffixLength) ?? 0;
    return TextEditingController(text: '$text位');
  }
}

@riverpod
class SuffixStartController extends _$SuffixStartController {
  @override
  TextEditingController build() {
    int text = StorageUtil.getInt(AppKeys.suffixStart) ?? 0;
    return TextEditingController(text: '$text开始');
  }
}

@riverpod
class ExtensionController extends _$ExtensionController {
  @override
  TextEditingController build() {
    TextEditingController controller = TextEditingController();
    controller.addListener(() {
      ref
          .read(extensionClearProvider.notifier)
          .update(controller.text.isNotEmpty);
    });
    return controller;
  }
}

@riverpod
class ExtensionClear extends _$ExtensionClear {
  @override
  bool build() => false;
  void update(bool value) => state = value;
}

@riverpod
class TargetController extends _$TargetController {
  @override
  TextEditingController build() {
    TextEditingController controller = TextEditingController();
    controller.addListener(() {
      ref.read(targetClearProvider.notifier).update(controller.text.isNotEmpty);
    });
    return controller;
  }
}

@riverpod
class TargetClear extends _$TargetClear {
  @override
  bool build() => false;
  void update(bool value) => state = value;
}
