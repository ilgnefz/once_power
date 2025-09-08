import 'dart:typed_data';

import 'package:once_power/enums/file.dart';
import 'package:once_power/models/file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'file.g.dart';

@riverpod
class FileList extends _$FileList {
  @override
  List<FileInfo> build() => [];

  void add(FileInfo file) => state = [...state, file];

  void addAll(List<FileInfo> list) => state = list;

  void clear() => state = [];

  void checkAll(bool check) => state = state.map((e) {
    if (e.checked != check) e.checked = check;
    return e;
  }).toList();

  void checkReverse() => state = state.map((e) {
    e.checked = !e.checked;
    return e;
  }).toList();

  void checkClassify(FileClassify classify, bool check) =>
      state = state.map((e) {
        if (e.type == classify) e.checked = check;
        return e;
      }).toList();

  void checkExtension(String ext) => state = state.map((e) {
    if (e.ext == ext) e.checked = !e.checked;
    return e;
  }).toList();

  void checkFolder(String folder) => state = state.map((e) {
    if (e.parent == folder) e.checked = !e.checked;
    return e;
  }).toList();

  void remove(FileInfo file) => state = state.where((e) => e != file).toList();

  void removeAt(int index) => state = state..removeAt(index);

  void removeCheck() => state = state.where((e) => !e.checked).toList();

  void removeFolder(String folder) =>
      state = state.where((e) => e.parent != folder).toList();

  void removeUncheck() => state = state.where((e) => e.checked).toList();

  void removeOtherClassify(List<FileClassify> classifyList) {
    state = state = state.where((e) => classifyList.contains(e.type)).toList();
  }

  // void update(FileInfo file) =>
  //     state = state.map((e) => e.id == file.id ? file : e).toList();

  void updateCheck(String id, bool value) => state = state.map((e) {
    if (e.id == id) e.checked = value;
    return e;
  }).toList();

  void updateDate(
    String id,
    DateTime? createdDate,
    DateTime? modifiedDate,
    DateTime? accessedDate,
  ) {
    state = state.map((e) {
      if (e.id == id) {
        e.createdDate = createdDate ?? e.createdDate;
        e.modifiedDate = modifiedDate ?? e.modifiedDate;
        e.accessedDate = accessedDate ?? e.accessedDate;
      }
      return e;
    }).toList();
  }

  void updateFolder(String id, String value) => state = state.map((e) {
    if (e.id == id) e.parent = value;
    return e;
  }).toList();

  void updateGroup(String id, String value) => state = state.map((e) {
    if (e.id == id) e.group = value;
    return e;
  }).toList();

  void updateNewExt(String id, String value) => state = state.map((e) {
    if (e.id == id) e.newExt = value;
    return e;
  }).toList();

  void updateNewName(String id, String value) => state = state.map((e) {
    if (e.id == id) e.newName = value;
    return e;
  }).toList();

  void updateOriginName(String id, String value) => state = state.map((e) {
    if (e.id == id) e.name = value;
    return e;
  }).toList();

  void updateOriginExt(String id, String value) => state = state.map((e) {
    if (e.id == id) e.ext = value;
    return e;
  }).toList();

  void updatePath(String id, String value) => state = state.map((e) {
    if (e.id == id) e.path = value;
    return e;
  }).toList();

  void updateTempPath(String id, String value) => state = state.map((e) {
    if (e.id == id) e.tempPath = value;
    return e;
  }).toList();

  void updateThumbnail(String id, Uint8List value) => state = state.map((e) {
    if (e.id == id) e.thumbnail = value;
    return e;
  }).toList();

  void insertAt(int index, FileInfo file) {
    if (index == 0) {
      state = [file, ...state];
    } else if (index == state.length) {
      state = [...state, file];
    } else {
      state = [...state.take(index), file, ...state.skip(index)];
    }
  }

  void insertCenter(List<FileInfo> files) => state = [
    ...state.take(state.length ~/ 2),
    ...files,
    ...state.skip(state.length ~/ 2),
  ];

  void insertFirst(List<FileInfo> files) => state = [...files, ...state];

  void insertLast(List<FileInfo> files) => state = [...state, ...files];

  void insertPosition(int index, List<FileInfo> files) {
    state = [...state.take(index), ...files, ...state.skip(index)];
  }
}

@riverpod
class SortHoverFile extends _$SortHoverFile {
  @override
  FileInfo? build() => null;
  void update(FileInfo? value) => state = value;
}

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
class PrefixUploadMark extends _$PrefixUploadMark {
  @override
  UploadMarkInfo? build() => null;
  void update(UploadMarkInfo? value) => state = value;
  void clear() => state = null;
}

@riverpod
class SuffixUploadMark extends _$SuffixUploadMark {
  @override
  UploadMarkInfo? build() => null;
  void update(UploadMarkInfo? value) => state = value;
  void clear() => state = null;
}
