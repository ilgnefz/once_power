import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/file_enum.dart';
import 'file.dart';

part 'toggle.g.dart';

@riverpod
class IsMax extends _$IsMax {
  @override
  bool build() => false;
  void update() => state = !state;
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
      createLocalRegedit();
    } else {
      // removeGlobalRegedit();
      removeLocalRegedit();
    }
    await StorageUtil.setBool(AppKeys.isUseRegedit, state);
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
class OpenExtraFunction extends _$OpenExtraFunction {
  @override
  bool build() => StorageUtil.getNullBool(AppKeys.isUseExtraFunction) ?? true;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isUseExtraFunction, state);
  }
}

@riverpod
class IsShowTip extends _$IsShowTip {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class HasNewVersion extends _$HasNewVersion {
  @override
  bool build() => false;
  void update(bool value) => state = value;
}

@riverpod
class IsInputLength extends _$IsInputLength {
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
class IsModifyExtension extends _$IsModifyExtension {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isSuffixSwap);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isSuffixSwap, state);
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
class CaseFile extends _$CaseFile {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isCaseFile);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isCaseFile, state);
  }
}

@riverpod
class CaseExtension extends _$CaseExtension {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isCaseExtension);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isCaseExtension, state);
  }
}

@riverpod
class ClassifyFile extends _$ClassifyFile {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isClassifyFile);
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isClassifyFile, state);
  }
}

@riverpod
bool checkAudio(Ref ref) {
  List<FileInfo> audioList = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.audio)
      .toList();
  int check = audioList.where((e) => e.checked == true).length;
  return check >= audioList.length;
}

@riverpod
bool checkFolder(Ref ref) {
  List<FileInfo> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.folder)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool checkImage(Ref ref) {
  List<FileInfo> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.image)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool checkOther(Ref ref) {
  List<FileInfo> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.other)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool checkText(Ref ref) {
  List<FileInfo> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.doc)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool checkVideo(Ref ref) {
  List<FileInfo> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.video)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool checkZip(Ref ref) {
  List<FileInfo> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.zip)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
class IsMatchExtension extends _$IsMatchExtension {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class IsDeleteExtension extends _$IsDeleteExtension {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class OpenUndo extends _$OpenUndo {
  @override
  bool build() => false;
  void update(bool value) => state = value;
}

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
class UseRuleOrganize extends _$UseRuleOrganize {
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
class UseTopParents extends _$UseTopParents {
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
class UseDateClassify extends _$UseDateClassify {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isUseDateClassify);
  Future<void> update(bool value) async {
    state = value;
    await StorageUtil.setBool(AppKeys.isUseDateClassify, state);
  }

  Future<void> toggle() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isUseDateClassify, state);
  }
}

@riverpod
class ShowChange extends _$ShowChange {
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
