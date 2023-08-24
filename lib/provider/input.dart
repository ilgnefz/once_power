import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'input.g.dart';

// @riverpod
// class MatchText extends _$MatchText {
//   @override
//   String build() => '';
//   void update(String value) => state = value;
// }
//
// @riverpod
// class ModifyText extends _$ModifyText {
//   @override
//   String build() => '';
//   void update(String value) => state = value;
// }

@riverpod
class MatchController extends _$MatchController {
  @override
  TextEditingController build() {
    TextEditingController controller = TextEditingController();
    controller.addListener(() {
      ref.read(matchClearProvider.notifier).update(controller.text.isNotEmpty);
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

// @riverpod
// class MatchLength extends _$MatchLength {
//   @override
//   int build() => 0;
//   void update(int value) => state = value;
// }

// @riverpod
// class DateLength extends _$DateLength {
//   @override
//   int build() => 8;
//   void update(int value) => state = value;
// }

@riverpod
class DateLengthController extends _$DateLengthController {
  @override
  TextEditingController build() => TextEditingController(text: '8位');
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

// @riverpod
// class PrefixFileValue extends _$PrefixFileValue {
//   @override
//   List<String> build() => state;
//   void update(List<String> value) => state = value;
// }
//
// @riverpod
// class PrefixFileName extends _$PrefixFileName {
//   @override
//   String build() => '';
//   void update(String value) => state = value;
// }

@riverpod
class PrefixLengthController extends _$PrefixLengthController {
  @override
  TextEditingController build() => TextEditingController(text: '0位');
}

@riverpod
class PrefixStartController extends _$PrefixStartController {
  @override
  TextEditingController build() => TextEditingController(text: '0开始');
}

// @riverpod
// class PrefixNumLength extends _$PrefixNumLength {
//   @override
//   int build() => 0;
//   void update(int value) => state = value;
// }
//
// @riverpod
// class PrefixNumStart extends _$PrefixNumStart {
//   @override
//   int build() => 0;
//   void update(int value) => state = value;
// }

// @riverpod
// class SuffixText extends _$SuffixText {
//   @override
//   String build() => '';
//   void update(String value) => state = value;
// }
//
// @riverpod
// class SuffixNumLength extends _$SuffixNumLength {
//   @override
//   int build() => 0;
//   void update(int value) => state = value;
// }
//
// @riverpod
// class SuffixNumStart extends _$SuffixNumStart {
//   @override
//   int build() => 0;
//   void update(int value) => state = value;
// }

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

// @riverpod
// class SuffixFileValue extends _$SuffixFileValue {
//   @override
//   List<String> build() => state;
//   void update(List<String> value) => state = value;
// }
//
// @riverpod
// class SuffixFileName extends _$SuffixFileName {
//   @override
//   String build() => '';
//   void update(String value) => state = value;
// }

@riverpod
class SuffixLengthController extends _$SuffixLengthController {
  @override
  TextEditingController build() => TextEditingController(text: '0位');
}

@riverpod
class SuffixStartController extends _$SuffixStartController {
  @override
  TextEditingController build() => TextEditingController(text: '0开始');
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
