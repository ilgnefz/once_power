import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/utils/regedit.dart';
import 'package:once_power/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select.g.dart';

// TopBar Start

@riverpod
class MaxWindow extends _$MaxWindow {
  @override
  bool build() => false;
  void update() => state = !state;
}

// ActionBar Start

@riverpod
class InputLength extends _$InputLength {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isLength) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isLength, state);
  }
}

@riverpod
class MatchCase extends _$MatchCase {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isCase) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isCase, state);
  }
}

@riverpod
class DateRename extends _$DateRename {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isDate) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isDate, state);
  }
}

@riverpod
class CyclePrefix extends _$CyclePrefix {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isPrefixCycle) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isPrefixCycle, state);
  }
}

@riverpod
class CycleSuffix extends _$CycleSuffix {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isSuffixCycle) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isSuffixCycle, state);
  }
}

@riverpod
class SwapPrefix extends _$SwapPrefix {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isPrefixSwap) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isPrefixSwap, state);
  }
}

@riverpod
class SwapSuffix extends _$SwapSuffix {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isSuffixSwap) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isSuffixSwap, state);
  }
}

@riverpod
class ModifyExtension extends _$ModifyExtension {
  @override
  bool build() => false;
  void update() => state = !state;
  void close() => state = false;
}

@riverpod
class AppendMode extends _$AppendMode {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isAppend) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isAppend, state);
  }
}

@riverpod
class AddFolder extends _$AddFolder {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isAddFolder) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isAddFolder, state);
  }
}

@riverpod
class AddSubfolder extends _$AddSubfolder {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isAddSubfolder) ?? false;
  void update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isAddSubfolder, state);
  }
}

@riverpod
class UseTopFolder extends _$UseTopFolder {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isUseTopFolder) ?? false;
  void update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isUseTopFolder, state);
  }
}

@riverpod
class CaseClassify extends _$CaseClassify {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isCaseClassify) ?? false;
  void update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isCaseClassify, state);
  }
}

@riverpod
class CaseExtension extends _$CaseExtension {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isCaseExtension) ?? false;
  void update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isCaseExtension, state);
  }
}

// ContentBar Start

@riverpod
bool selectAudio(Ref ref) {
  List<FileInfo> audioList = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.audio)
      .toList();
  int check = audioList.where((e) => e.checked == true).length;
  return check >= audioList.length;
}

@riverpod
bool selectFolder(Ref ref) {
  List<FileInfo> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.folder)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool selectImage(Ref ref) {
  List<FileInfo> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.image)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool selectOther(Ref ref) {
  List<FileInfo> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.other)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool selectText(Ref ref) {
  List<FileInfo> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.doc)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool selectVideo(Ref ref) {
  List<FileInfo> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.video)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool selectZip(Ref ref) {
  List<FileInfo> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.zip)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
class RefreshImage extends _$RefreshImage {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class ClassifiedFile extends _$ClassifiedFile {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isClassifiedFile) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isClassifiedFile, state);
  }
}

@riverpod
class UseTimeClassification extends _$UseTimeClassification {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isUseTimeClassification) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isUseTimeClassification, state);
  }
}

// BottomBar Start

@riverpod
class SaveConfig extends _$SaveConfig {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isSave) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isSave, state);
  }
}

@riverpod
class UseRegedit extends _$UseRegedit {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isUseRegedit) ?? false;
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
class SaveLog extends _$SaveLog {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isSaveLog) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isSaveLog, state);
  }
}

@riverpod
class ViewMode extends _$ViewMode {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isViewMode) ?? false;
  void update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isViewMode, state);
  }
}

@riverpod
class AutoRun extends _$AutoRun {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isAutoRun) ?? false;
  void update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isAutoRun, state);
  }
}

@riverpod
class ExtraFunction extends _$ExtraFunction {
  @override
  bool build() => StorageUtil.getBool(AppKeys.isUseExtraFunction) ?? false;
  Future<void> update() async {
    state = !state;
    await StorageUtil.setBool(AppKeys.isUseExtraFunction, state);
  }
}

@riverpod
class ShowTip extends _$ShowTip {
  @override
  bool build() => false;
  void update() => state = true;
}

@riverpod
class NewVersion extends _$NewVersion {
  @override
  bool build() => false;
  void update(bool value) => state = value;
}
