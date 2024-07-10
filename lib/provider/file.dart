import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/core/rename.dart';
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

  void check(String id) => state = state.map((e) {
        if (e.id == id) e.checked = !e.checked;
        return e;
      }).toList();

  void removeUncheck() => state = state.where((e) => e.checked).toList();

  void removeOtherClassify(FileClassify classify) {
    state = state = state.where((e) => e.type == classify).toList();
  }

  void checkAll(bool check) => state = state.map((e) {
        if (e.checked != check) e.checked = check;
        return e;
      }).toList();

  void checkPart(FileClassify classify, bool check) => state = state.map((e) {
        if (e.type == classify) e.checked = check;
        return e;
      }).toList();

  // void uncheckClassify(FileClassify classify) => state = state.map((e) {
  //       if (e.type != classify) e.checked = false;
  //       return e;
  //     }).toList();

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
}

@riverpod
List<FileInfo> sortList(SortListRef ref) {
  final type = ref.watch(fileSortTypeProvider);
  final list = ref.watch(fileListProvider);

  List<FileInfo> sortedList;

  switch (type) {
    case SortType.nameDescending:
      sortedList = [...list]..sort((a, b) => a.name.compareTo(b.name));
      break;
    case SortType.nameAscending:
      sortedList = [...list]..sort((a, b) => b.name.compareTo(a.name));
      break;
    case SortType.dateDescending:
      sortedList = [...list]..sort((a, b) {
          int result = sortDateTime(a).first.compareTo(sortDateTime(b).first);
          return result == 0 ? a.name.compareTo(b.name) : result;
        });
      break;
    case SortType.dateAscending:
      sortedList = [...list]..sort((a, b) {
          int result = sortDateTime(b).first.compareTo(sortDateTime(a).first);
          return result == 0 ? b.name.compareTo(a.name) : result;
        });
      break;
    case SortType.typeDescending:
      sortedList = [...list]
        ..sort((a, b) => a.extension.compareTo(b.extension));
      break;
    case SortType.typeAscending:
      sortedList = [...list]
        ..sort((a, b) => b.extension.compareTo(a.extension));
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
FileClassify getFileClassify(GetFileClassifyRef ref, String extension) {
  FileClassify classify = FileClassify.other;
  if (audio.contains(extension)) classify = FileClassify.audio;
  if (folder == extension) classify = FileClassify.folder;
  if (image.contains(extension)) classify = FileClassify.image;
  if (text.contains(extension)) classify = FileClassify.text;
  if (video.contains(extension)) classify = FileClassify.video;
  if (zip.contains(extension)) classify = FileClassify.zip;
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

@riverpod
class TempList extends _$TempList {
  @override
  List<RenameInfo> build() => [];

  void add(RenameInfo value) => state = [...state, value];
  void remove(RenameInfo value) =>
      state = state.where((e) => e != value).toList();
}

@riverpod
class BadList extends _$BadList {
  @override
  List<String> build() => [];
  void add(String value) => state = [...state, value];
}

@riverpod
class CSVData extends _$CSVData {
  @override
  List<List<String>> build() => [];
  void update(List<List<String>> value) => state = value;
}

@riverpod
List<EasyRenameInfo> easyRenameInfoList(EasyRenameInfoListRef ref) {
  List<EasyRenameInfo> list = [];
  for (var e in ref.watch(cSVDataProvider)) {
    list.add(EasyRenameInfo(nameA: e.firstOrNull!, nameB: e.lastOrNull!));
  }
  return list;
}

// @riverpod
// class EasyRenameList extends _$EasyRenameList {
//   @override
//   List<EasyRenameInfo> build() => ref.cSVDataProvider.map((e) => ).toList();
//   void update(List<EasyRenameInfo> value) => state = value;
// }
