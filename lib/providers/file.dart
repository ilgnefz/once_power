import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/models/file_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'file.g.dart';

@riverpod
class FileList extends _$FileList {
  @override
  List<FileInfo> build() => [];

  void add(FileInfo file) => state = [...state, file];

  void addAll(List<FileInfo> list) => state = list;

  void clear() => state = [];

  void remove(String id) => state = state.where((e) => e.id != id).toList();

  void removeAt(int index) => state = state..removeAt(index);

  void removeFolder(String folder) =>
      state = state.where((e) => e.parent != folder).toList();

  void insertAt(int index, FileInfo file) {
    if (index == 0) {
      state = [file, ...state];
    } else if (index == state.length) {
      state = [...state, file];
    } else {
      state = [...state.take(index), file, ...state.skip(index)];
    }
  }

  void insertFirst(List<FileInfo> files) => state = [...files, ...state];

  void insertCenter(List<FileInfo> files) => state = [
        ...state.take(state.length ~/ 2),
        ...files,
        ...state.skip(state.length ~/ 2)
      ];

  void insertLast(List<FileInfo> files) => state = [...state, ...files];

  void check(String id) => state = state.map((e) {
        if (e.id == id) e.checked = !e.checked;
        return e;
      }).toList();

  void removeCheck() => state = state.where((e) => !e.checked).toList();

  void removeUncheck() => state = state.where((e) => e.checked).toList();

  void removeOtherClassify(List<FileClassify> classifyList) {
    state = state = state.where((e) => classifyList.contains(e.type)).toList();
  }

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
        if (e.extension == ext) e.checked = !e.checked;
        return e;
      }).toList();

  void checkFolder(String folder) => state = state.map((e) {
        if (e.parent == folder) e.checked = !e.checked;
        return e;
      }).toList();

  void updateOriginName(String id, String name) => state = state.map((e) {
        if (e.id == id) e.name = name;
        return e;
      }).toList();

  void updateFilePath(String id, String filePath) => state = state.map((e) {
        if (e.id == id) e.filePath = filePath;
        return e;
      }).toList();

  void updateFileParent(String id, String folder) => state = state.map((e) {
        if (e.id == id) e.parent = folder;
        return e;
      }).toList();

  void updateName(String id, String name) => state = state.map((e) {
        if (e.id == id) e.newName = name;
        return e;
      }).toList();

  void updateOriginExtension(String id, String extension) =>
      state = state.map((e) {
        if (e.id == id) e.extension = extension;
        return e;
      }).toList();

  void updateExtension(String id, String extension) => state = state.map((e) {
        if (e.id == id) e.newExtension = extension;
        return e;
      }).toList();

  void updateTempPath(String id, String path) => state = state.map((e) {
        if (e.id == id) e.tempPath = path;
        return e;
      }).toList();

  void updateGroup(String id, String group) => state = state.map((e) {
        if (e.id == id) e.group = group;
        return e;
      }).toList();

  void updateResolution(String id, Resolution? resolution) =>
      state = state.map((e) {
        if (e.id == id) e.resolution = resolution;
        return e;
      }).toList();
}

@riverpod
int selectFile(Ref ref) =>
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
class SortSelectList extends _$SortSelectList {
  @override
  List<FileInfo> build() => [];
  void add(FileInfo value) => state = [...state, value];
  void addAll(List<FileInfo> value) => state = [...state, ...value];
  void remove(FileInfo value) =>
      state = state.where((e) => e != value).toList();
  void one(FileInfo value) => state = [value];
  void clear() => state = [];
}

@riverpod
class SortHoverFile extends _$SortHoverFile {
  @override
  FileInfo? build() => null;
  void update(FileInfo? value) => state = value;
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
