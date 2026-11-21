import 'dart:async';

import 'package:once_power/constant/key.dart';
import 'package:once_power/service/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toggle.g.dart';

/* ---------- Action ---------- */
@riverpod
class IsInputLength extends _$IsInputLength {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.length);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.length, state));
  }
}

@riverpod
class IsIgnoreCase extends _$IsIgnoreCase {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.ignoreCase);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.ignoreCase, state));
  }
}

@riverpod
class IsDateRename extends _$IsDateRename {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.isDateRename);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.isDateRename, state));
  }
}

@riverpod
class IsCyclePrefix extends _$IsCyclePrefix {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.isCyclePrefix);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.isCyclePrefix, state));
  }
}

@riverpod
class IsSwapPrefix extends _$IsSwapPrefix {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.isSwapPrefix);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.isSwapPrefix, state));
  }
}

@riverpod
class IsCycleSuffix extends _$IsCycleSuffix {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.isCycleSuffix);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.isCycleSuffix, state));
  }
}

@riverpod
class IsSwapSuffix extends _$IsSwapSuffix {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.isSwapSuffix);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.isSwapSuffix, state));
  }
}

@riverpod
class IsModifyExtension extends _$IsModifyExtension {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.isModifyExtension);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.isModifyExtension, state));
  }
}

@riverpod
class IsCaseType extends _$IsCaseType {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.caseType);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.caseType, state));
  }
}

@riverpod
class IsCaseExtension extends _$IsCaseExtension {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.caseExtension);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.caseExtension, state));
  }
}

@riverpod
class IsAddFolder extends _$IsAddFolder {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.addFolder);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.addFolder, state));
  }
}

@riverpod
class IsAddSubfolder extends _$IsAddSubfolder {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.addSubfolder);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.addSubfolder, state));
  }
}

@riverpod
class IsAppend extends _$IsAppend {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.append);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.append, state));
  }
}

/* ---------- Bottom ---------- */

@riverpod
class IsViewMode extends _$IsViewMode {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.viewMode);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.viewMode, state));
  }
}

@riverpod
class IsTVMode extends _$IsTVMode {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.tvMode);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.tvMode, state));
  }
}

@riverpod
class IsCSVMode extends _$IsCSVMode {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.csvMode);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.csvMode, state));
  }
}

@riverpod
class IsDateMode extends _$IsDateMode {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.dateMode);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.dateMode, state));
  }
}

/* ---------- Setting ---------- */

@riverpod
class IsSwapLabel extends _$IsSwapLabel {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.swapLabel);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.swapLabel, state));
  }
}

@riverpod
class IsHiddenUnit extends _$IsHiddenUnit {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.isHiddenUnit);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.isHiddenUnit, state));
  }
}

@riverpod
class IsLightSync extends _$IsLightSync {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.isLightSync);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.isLightSync, state));
  }
}

@riverpod
class IsLightTransparent extends _$IsLightTransparent {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.isLightTransparent);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.isLightTransparent, state));
  }
}

@riverpod
class IsDarkSync extends _$IsDarkSync {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.isDarkSync);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.isDarkSync, state));
  }
}

@riverpod
class IsDarkTransparent extends _$IsDarkTransparent {
  @override
  bool build() => StorageService.getBoolDefault(AppKeys.isDarkTransparent);

  void toggle() {
    state = !state;
    unawaited(StorageService.setBool(AppKeys.isDarkTransparent, state));
  }
}
