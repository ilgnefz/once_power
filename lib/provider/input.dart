import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'toggle.dart';

part 'input.g.dart';

// Rename Mode

@riverpod
class MatchController extends _$MatchController {
  @override
  TextEditingController build() {
    TextEditingController controller = TextEditingController();
    controller.addListener(() {
      ref.read(matchClearProvider.notifier).update(controller.text.isNotEmpty);
      ref.read(currentReserveTypeProvider.notifier).clear();
    });
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  }

  void updateText(String text) {
    state.text = text;
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
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  }

  void updateText(String text) {
    state.text = text;
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
    String unit = S.current.digits;
    TextEditingController controller =
        TextEditingController(text: '$text$unit');
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
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
    ref.onDispose(() {
      controller.dispose();
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
    String unit = S.current.digits;
    TextEditingController controller =
        TextEditingController(text: '$text$unit');
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  }
}

@riverpod
class PrefixStartController extends _$PrefixStartController {
  @override
  TextEditingController build() {
    int text = StorageUtil.getInt(AppKeys.prefixStart) ?? 0;
    String unit = S.current.start;
    TextEditingController controller =
        TextEditingController(text: '$text$unit');
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
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
    ref.onDispose(() {
      controller.dispose();
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
    String unit = S.current.digits;
    TextEditingController controller =
        TextEditingController(text: '$text$unit');
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  }
}

@riverpod
class SuffixStartController extends _$SuffixStartController {
  @override
  TextEditingController build() {
    int text = StorageUtil.getInt(AppKeys.suffixStart) ?? 0;
    String unit = S.current.start;
    TextEditingController controller =
        TextEditingController(text: '$text$unit');
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
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
    ref.onDispose(() {
      controller.dispose();
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

// Organize Mode

@riverpod
class TargetController extends _$TargetController {
  @override
  TextEditingController build() {
    String? folder = StorageUtil.getString(AppKeys.targetFolder);
    TextEditingController controller = TextEditingController(text: folder);
    controller.addListener(() {
      ref.read(targetClearProvider.notifier).update(controller.text.isNotEmpty);
    });
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  }
}

@riverpod
class TargetClear extends _$TargetClear {
  @override
  bool build() => StorageUtil.getString(AppKeys.targetFolder) != null;
  void update(bool value) => state = value;
}

// ContentBar

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
