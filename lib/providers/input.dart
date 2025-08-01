import 'package:flutter/material.dart';
import 'package:once_power/constants/keys.dart';
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
    });
    ref.onDispose(() {
      controller.dispose();
    });
    return controller;
  }

  void updateText(String text) => state.text = text;

  void clear() {
    state.clear();
    ref.read(matchClearProvider.notifier).update(false);
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

  void updateText(String text) => state.text = text;

  void clear() {
    state.clear();
    ref.read(modifyClearProvider.notifier).update(false);
  }
}

@riverpod
class ModifyClear extends _$ModifyClear {
  @override
  bool build() => false;
  void update(bool value) => state = value;
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

  void clear() {
    state.clear();
    ref.read(prefixClearProvider.notifier).update(false);
  }
}

@riverpod
class PrefixClear extends _$PrefixClear {
  @override
  bool build() => false;
  void update(bool value) => state = value;
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

  void clear() {
    state.clear();
    ref.read(suffixClearProvider.notifier).update(false);
  }
}

@riverpod
class SuffixClear extends _$SuffixClear {
  @override
  bool build() => false;
  void update(bool value) => state = value;
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

  void clear() {
    state.clear();
    ref.read(extensionClearProvider.notifier).update(false);
  }
}

@riverpod
class ExtensionClear extends _$ExtensionClear {
  @override
  bool build() => false;
  void update(bool value) => state = value;
}

/* Organize Mode */
@riverpod
class FolderController extends _$FolderController {
  @override
  TextEditingController build() {
    String? folder = StorageUtil.getString(AppKeys.targetFolder);
    TextEditingController controller = TextEditingController(text: folder);
    controller.addListener(() {
      ref.read(folderClearProvider.notifier).update(controller.text.isNotEmpty);
    });
    return controller;
  }

  void updateText(String text) => state.text = text;

  void clear() {
    state.clear();
    ref.read(folderClearProvider.notifier).update(false);
  }
}

@riverpod
class FolderClear extends _$FolderClear {
  @override
  bool build() => ref.watch(folderControllerProvider).text != '';
  void update(bool value) => state = value;
}
