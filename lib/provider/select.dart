// import 'package:once_power/model/types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select.g.dart';

@riverpod
class MatchCase extends _$MatchCase {
  @override
  bool build() => false;
  void update() => state = !state;
}

// @riverpod
// class ModeSwitch extends _$ModeSwitch {
//   @override
//   ModeType build() => ModeType.general;
//   void update(ModeType type) => state = type;
// }

@riverpod
class DateRename extends _$DateRename {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class CyclePrefix extends _$CyclePrefix {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class CycleSuffix extends _$CycleSuffix {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class SwapPrefix extends _$SwapPrefix {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class SwapSuffix extends _$SwapSuffix {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class ModifyExtension extends _$ModifyExtension {
  @override
  bool build() => false;
  void update() => state = !state;
}
