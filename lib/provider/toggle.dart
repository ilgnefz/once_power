import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/utils/regedit.dart';
import 'package:once_power/utils/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'file.dart';

part 'toggle.g.dart';

/* ----- System ----- */
@riverpod
class IsMax extends _$IsMax {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isMaxed);
  void update() async => state = !state;
}

/* ----- Action Rename ----- */
@riverpod
class IsInputLen extends _$IsInputLen {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isLength);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isLength, state);
  }
}

@riverpod
class IsCaseSensitive extends _$IsCaseSensitive {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isCase);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isCase, state);
  }
}

@riverpod
class IsDateRename extends _$IsDateRename {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isDate);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isDate, state);
  }
}

@riverpod
class IsCyclePrefix extends _$IsCyclePrefix {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isPrefixCycle);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isPrefixCycle, state);
  }
}

@riverpod
class IsSwapPrefix extends _$IsSwapPrefix {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isPrefixSwap);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isPrefixSwap, state);
  }
}

@riverpod
class IsCycleSuffix extends _$IsCycleSuffix {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isSuffixCycle);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isSuffixCycle, state);
  }
}

@riverpod
class IsSwapSuffix extends _$IsSwapSuffix {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isSuffixSwap);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isSuffixSwap, state);
  }
}

@riverpod
class IsModifyExt extends _$IsModifyExt {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isSuffixSwap);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isSuffixSwap, state);
  }
}

/* ----- Action CSV ----- */
@riverpod
class DeleteExtension extends _$DeleteExtension {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class MatchExtension extends _$MatchExtension {
  @override
  bool build() => false;
  void update() => state = !state;
}

/* ----- Action Rename Bottom ----- */
@riverpod
class CaseFile extends _$CaseFile {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isCaseFile);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isCaseFile, state);
  }
}

@riverpod
class CaseExt extends _$CaseExt {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isCaseExtension);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isCaseExtension, state);
  }
}

/* ----- Action Organize Bottom ----- */
@riverpod
class UseGroupOrganize extends _$UseGroupOrganize {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isUseGroupOrganize);
  Future<void> update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.isUseGroupOrganize, state);
  }

  Future<void> toggle() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isUseGroupOrganize, state);
  }
}

@riverpod
class UseTypeOrganize extends _$UseTypeOrganize {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isUseRuleOrganize);
  Future<void> update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.isUseRuleOrganize, state);
  }

  Future<void> toggle() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isUseRuleOrganize, state);
  }
}

@riverpod
class UseTopFolder extends _$UseTopFolder {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isUseTopFolder);
  Future<void> update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.isUseTopFolder, state);
  }

  Future<void> toggle() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isUseTopFolder, state);
  }
}

@riverpod
class UseDateOrganize extends _$UseDateOrganize {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isUseDateOrganize);
  Future<void> update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.isUseDateOrganize, state);
  }

  Future<void> toggle() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isUseDateOrganize, state);
  }
}

/* ----- Action Common Bottom ----- */

@riverpod
class IsAddFolder extends _$IsAddFolder {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isAddFolder);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isAddFolder, state);
  }
}

@riverpod
class IsAddSubfolder extends _$IsAddSubfolder {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isAddSubfolder);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isAddSubfolder, state);
  }
}

@riverpod
class IsAppendMode extends _$IsAppendMode {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isAppend);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isAppend, state);
  }
}

// ----- Content -----

@riverpod
class OnlyChange extends _$OnlyChange {
  @override
  bool build() => false;
  void update() => state = !state;
  void reset() => state = false;
}

@riverpod
class ExpandNewName extends _$ExpandNewName {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
bool checkArchive(Ref ref) {
  List<FileInfo> list =
      ref.watch(fileListProvider).where((e) => e.type.isArchive).toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool checkAudio(Ref ref) {
  List<FileInfo> audioList =
      ref.watch(fileListProvider).where((e) => e.type.isAudio).toList();
  int check = audioList.where((e) => e.checked == true).length;
  return check >= audioList.length;
}

@riverpod
bool checkFolder(Ref ref) {
  List<FileInfo> list =
      ref.watch(fileListProvider).where((e) => e.type.isFolder).toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool checkImage(Ref ref) {
  List<FileInfo> list =
      ref.watch(fileListProvider).where((e) => e.type.isImage).toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool checkOther(Ref ref) {
  List<FileInfo> list =
      ref.watch(fileListProvider).where((e) => e.type.isOther).toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool checkText(Ref ref) {
  List<FileInfo> list =
      ref.watch(fileListProvider).where((e) => e.type.isDoc).toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool checkVideo(Ref ref) {
  List<FileInfo> list =
      ref.watch(fileListProvider).where((e) => e.type.isVideo).toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

// ----- Bottom -----
@riverpod
class IsSaveConfig extends _$IsSaveConfig {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isSave);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isSave, state);
  }
}

@riverpod
class IsUseRegedit extends _$IsUseRegedit {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isUseRegedit);
  Future<void> update() async {
    state = !state;
    if (state) {
      // createGlobalRegedit();
      AppRegedit.createLocalRegedit();
    } else {
      // removeGlobalRegedit();
      AppRegedit.removeLocalRegedit();
    }
    await StorageUtil.setBool(AppKeys.isUseRegedit, state);
  }
}

@riverpod
class IsAutoRun extends _$IsAutoRun {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isAutoRun);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isAutoRun, state);
  }
}

@riverpod
class IsSaveLog extends _$IsSaveLog {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isSaveLog);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isSaveLog, state);
  }
}

@riverpod
class IsViewMode extends _$IsViewMode {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isViewMode);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isViewMode, state);
  }
}

@riverpod
class IsDateModify extends _$IsDateModify {
  @override
  bool build() => false;
  void toggle() => state = !state;
  void update(bool value) => state = value;
}

@riverpod
class ShowUndo extends _$ShowUndo {
  @override
  bool build() => false;
  void update(bool value) => state = value;
}
