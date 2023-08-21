import 'package:once_power/model/enum.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/provider/file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select.g.dart';

@riverpod
class InputLength extends _$InputLength {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class MatchCase extends _$MatchCase {
  @override
  bool build() => false;
  void update() => state = !state;
}

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

@riverpod
class AppendMode extends _$AppendMode {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
class AddFolder extends _$AddFolder {
  @override
  bool build() => false;
  void update() => state = !state;
}

/// TODO 底部取消按钮，似乎没用
@riverpod
class Cancel extends _$Cancel {
  @override
  bool build() => false;
  void update() => state = !state;
}

@riverpod
bool selectAudio(SelectAudioRef ref) {
  List<RenameFile> audioList = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.audio)
      .toList();
  int check = audioList.where((e) => e.checked == true).length;
  return check >= audioList.length;
}

@riverpod
bool selectFolder(SelectFolderRef ref) {
  List<RenameFile> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.folder)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool selectImage(SelectImageRef ref) {
  List<RenameFile> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.image)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool selectOther(SelectOtherRef ref) {
  List<RenameFile> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.other)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool selectText(SelectTextRef ref) {
  List<RenameFile> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.text)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}

@riverpod
bool selectVideo(SelectVideoRef ref) {
  List<RenameFile> list = ref
      .watch(fileListProvider)
      .where((e) => e.type == FileClassify.video)
      .toList();
  int check = list.where((e) => e.checked == true).toList().length;
  return check >= list.length / 2;
}
