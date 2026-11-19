import 'package:flutter_multi_select_reorder/flutter_multi_select_reorder.dart';
import 'package:once_power/model/file.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'file.g.dart';

@riverpod
class FileList extends _$FileList {
  @override
  List<FileInfo> build() => [];

  void add(FileInfo value) => state = [...state, value];

  void addAll(List<FileInfo> value) => state = [...state, ...value];

  void remove(FileInfo value) =>
      state = state.where((element) => element != value).toList();

  // void insertAt(int index, List<FileInfo> files) {
  //   if (index == 0) {
  //     state = [...files, ...state];
  //   } else if (index == state.length) {
  //     state = [...state, ...files];
  //   } else {
  //     state = [...state.take(index), ...files, ...state.skip(index)];
  //   }
  // }

  void reorder(List<int> oldIndices, List<int> newIndices) =>
      state = applyMultiReorder(state, oldIndices, newIndices);

  /// 只重排 `slots` 这些位置上的条目，其它位置保持不动。
  /// grid 只显示图片：先把重排算在图片子集上，再按顺序填回原来的图片槽位，
  /// 这样非图片项不会被挪走。
  void reorderAtSlots(
    List<int> slots,
    List<int> oldIndices,
    List<int> newIndices,
  ) {
    final List<FileInfo> next = List<FileInfo>.of(state);
    final List<FileInfo> reordered = applyMultiReorder(
      <FileInfo>[for (final int i in slots) state[i]],
      oldIndices,
      newIndices,
    );
    for (int i = 0; i < slots.length; i++) {
      next[slots[i]] = reordered[i];
    }
    state = next;
  }

  void clear() => state = [];

  void updateChecked(String id, bool value) => state = state.map((e) {
    if (e.id == id) e.checked = value;
    return e;
  }).toList();

  void toggleAllChecked(bool check) => state = state.map((e) {
    if (e.checked != check) e.checked = check;
    return e;
  }).toList();
}

@riverpod
List<FileInfo> sortList(Ref ref) {
  List<FileInfo> files = ref.watch(fileListProvider);
  List<FileInfo> sortedFiles = files.toList();

  return sortedFiles;
}

@riverpod
class PreviewFile extends _$PreviewFile {
  @override
  FileInfo? build() => null;

  void update(FileInfo? file) => state = file;
}
