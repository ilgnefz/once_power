import 'package:once_power/core/file.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/core/rename.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'toggle.dart';

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

  void checkClassify(FileClassify classify, bool check) =>
      state = state.map((e) {
        if (e.type == classify) e.checked = check;
        return e;
      }).toList();

  void checkExtension(String ext) => state = state.map((e) {
        if (e.extension == ext) e.checked = !e.checked;
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
}

@riverpod
List<FileInfo> sortList(SortListRef ref) {
  final type = ref.watch(fileSortTypeProvider);
  final list = ref.watch(fileListProvider);

  List<FileInfo> sortedList;

  switch (type) {
    case SortType.nameDescending:
      sortedList = splitSortList(list, false);
      break;
    case SortType.nameAscending:
      sortedList = splitSortList(list, true);
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
List<FileClassify> classifyList(ClassifyListRef ref) {
  List<FileClassify> classifyList = [];
  for (var e in ref.watch(fileListProvider)) {
    if (!classifyList.contains(e.type)) classifyList.add(e.type);
  }
  return classifyList;
}

// {
//  "image": ["jpg", "png"],
// "doc": ["txt"]
// }
@riverpod
Map<FileClassify, List<String>> extensionListMap(ExtensionListMapRef ref) {
  Map<FileClassify, List<String>> extMap = {};
  for (var e in ref.watch(fileListProvider)) {
    if (!extMap.containsKey(e.type)) {
      extMap[e.type] = [e.extension];
    } else {
      if (!extMap[e.type]!.contains(e.extension)) {
        extMap[e.type]!.add(e.extension);
      }
    }
  }
  for (var e in extMap.keys) {
    extMap[e]!.sort();
  }
  return extMap;
}

@riverpod
bool selectedExtension(SelectedExtensionRef ref, String ext) {
  return ref.watch(fileListProvider).every((e) {
    if (e.extension == ext) return e.checked;
    return true;
  });
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
