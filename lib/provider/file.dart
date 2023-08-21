import 'dart:io';

import 'package:once_power/model/enum.dart';
import 'package:once_power/model/rename_file.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'file.g.dart';

@riverpod
class FileList extends _$FileList {
  @override
  List<RenameFile> build() => [];

  void add(RenameFile file) => state = [...state, file];

  void clear() => state = [];

  void remove(String id) => state = state.where((e) => e.id != id).toList();

  void check(String id) => state = state.map((e) {
        if (e.id == id) e.checked = !e.checked;
        return e;
      }).toList();

  void removeUncheck() => state = state.where((e) => e.checked).toList();

  void checkAll(bool check) => state = state.map((e) {
        if (e.checked != check) e.checked = check;
        return e;
      }).toList();

  void checkPart(FileClassify classify, bool check) => state = state.map((e) {
        if (e.type == classify) e.checked = check;
        return e;
      }).toList();

  void sort() {
    state = state..sort((a, b) => a.name.compareTo(b.name));
  }
}

@riverpod
List<RenameFile> sortList(SortListRef ref) {
  final type = ref.watch(fileSortTypeProvider);
  final list = ref.watch(fileListProvider);

  List<RenameFile> sortedList;

  switch (type) {
    case SortType.nameDescending:
      sortedList = [...list]..sort((a, b) => a.name.compareTo(b.name));
      break;
    case SortType.nameAscending:
      sortedList = [...list]..sort((a, b) => b.name.compareTo(a.name));
      break;
    case SortType.checkDescending:
      sortedList = [...list]..sort((a, b) {
          if (a.checked == b.checked) return 0;
          return a.checked ? -1 : 1;
        });
      break;
    case SortType.checkAscending:
      sortedList = [...list]..sort((a, b) {
          if (a.checked == b.checked) return 0;
          return b.checked ? -1 : 1;
        });
      break;
    default:
      sortedList = list;
      break;
  }
  return sortedList;
}

@riverpod
int selectFile(SelectFileRef ref) =>
    ref.watch(fileListProvider).where((e) => e.checked).toList().length;

@riverpod
class SelectAll extends _$SelectAll {
  @override
  bool build() {
    if (ref.watch(fileListProvider).isEmpty) return true;
    int checked = ref
        .watch(fileListProvider)
        .where((e) => e.checked == true)
        .toList()
        .length;
    int total = ref.watch(fileListProvider).length;
    return checked >= total / 2;
  }

  void update() {
    state = !state;
    ref.read(fileListProvider.notifier).checkAll(state);
  }
}

@riverpod
List<String> getAllFile(GetAllFileRef ref, String folder) {
  Directory directory = Directory(folder);
  List<String> children = [];
  List<FileSystemEntity> files = directory.listSync(recursive: true);
  for (var file in files) {
    if (FileSystemEntity.isFileSync(file.path)) {
      String extension = path.extension(file.path);
      extension = extension == '' ? extension : extension.substring(1);
      if (!filter.contains(extension)) children.add(file.path);
    }
  }
  return children;
}

@riverpod
FileClassify getFileClassify(GetFileClassifyRef ref, String extension) {
  FileClassify classify = FileClassify.other;
  if (image.contains(extension)) classify = FileClassify.image;
  if (video.contains(extension)) classify = FileClassify.video;
  if (text.contains(extension)) classify = FileClassify.text;
  if (audio.contains(extension)) classify = FileClassify.audio;
  return classify;
}

@riverpod
List<FileClassify> classifyList(ClassifyListRef ref) {
  List<FileClassify> classifyList = [];
  for (var e in ref.watch(fileListProvider)) {
    if (!classifyList.contains(e.type)) classifyList.add(e.type);
  }
  return classifyList;
}
