import 'package:once_power/enum/file.dart';
import 'package:once_power/enum/sort.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/csv.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/util/info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'file.dart';
import 'select.dart';

part 'list.g.dart';

@riverpod
List<FileInfo> sortList(Ref ref) {
  SortType type = ref.watch(currentSortProvider);
  List<FileInfo> list = ref.watch(fileListProvider);
  List<FileInfo> sortedList = [];

  switch (type) {
    case SortType.nameAscending:
      // sortedList = splitSortList(list, false);
      sortedList = [...list]..sort((a, b) => naturalCompare(a.name, b.name));
      break;
    case SortType.nameDescending:
      // sortedList = splitSortList(list, true);
      sortedList = [...list]..sort((a, b) => naturalCompare(b.name, a.name));
      break;
    case SortType.dateAscending:
      sortedList = [...list]
        ..sort((a, b) {
          int result = a.createdDate.date.compareTo(b.createdDate.date);
          return result == 0 ? a.name.compareTo(b.name) : result;
        });
      break;
    case SortType.dateDescending:
      sortedList = [...list]
        ..sort((a, b) {
          int result = b.createdDate.date.compareTo(a.createdDate.date);
          return result == 0 ? b.name.compareTo(a.name) : result;
        });
      break;
    case SortType.typeAscending:
      sortedList = [...list]
        ..sort((a, b) => a.extension.compareTo(b.extension));
      break;
    case SortType.typeDescending:
      sortedList = [...list]
        ..sort((a, b) => b.extension.compareTo(a.extension));
      break;
    case SortType.checkAscending:
      sortedList = [...list]
        ..sort((a, b) {
          if (a.checked == b.checked) return 0;
          return a.checked ? -1 : 1;
        });
      break;
    case SortType.checkDescending:
      sortedList = [...list]
        ..sort((a, b) {
          if (a.checked == b.checked) return 0;
          return b.checked ? -1 : 1;
        });
      break;
    case SortType.sizeAscending:
      sortedList = [...list]
        ..sort((a, b) {
          if (a.size == b.size) return 0;
          return a.size.compareTo(b.size);
        });
      break;
    case SortType.sizeDescending:
      sortedList = [...list]
        ..sort((a, b) {
          if (a.size == b.size) return 0;
          return b.size.compareTo(a.size);
        });
      break;
    case SortType.groupAscending:
      sortedList = [...list]
        ..sort((a, b) {
          if (a.group == b.group) return 0;
          return a.group.compareTo(b.group);
        });
      break;
    case SortType.groupDescending:
      sortedList = [...list]
        ..sort((a, b) {
          if (a.group == b.group) return 0;
          return b.group.compareTo(a.group);
        });
      break;
    case SortType.folderAscending:
      sortedList = [...list]
        ..sort((a, b) {
          if (a.parent == b.parent) return 0;
          return a.parent.compareTo(b.parent);
        });
      break;
    case SortType.folderDescending:
      sortedList = [...list]
        ..sort((a, b) {
          if (a.parent == b.parent) return 0;
          return b.parent.compareTo(a.parent);
        });
      break;
    default:
      sortedList = list;
      break;
  }
  return sortedList;
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
List<CountFileType> fileTypeList(Ref ref) {
  List<CountFileType> list = [];
  for (FileInfo file in ref.watch(fileListProvider)) {
    int index = list.indexWhere((e) => e.type == file.type);
    if (index != -1) {
      list[index] = list[index].copyWith(count: list[index].count + 1);
    } else {
      list.add(CountFileType(type: file.type, count: 1));
    }
  }
  return list;
}

@riverpod
Map<FileType, List<String>> extensionListMap(Ref ref) {
  Map<FileType, List<String>> extMap = {};
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
bool selectedExtension(Ref ref, String ext) {
  return ref.watch(fileListProvider).every((e) {
    if (e.extension == ext) return e.checked;
    return true;
  });
}

@riverpod
List<String> pathList(Ref ref) {
  List<String> list = [];
  for (FileInfo e in ref.watch(fileListProvider)) {
    if (!list.contains(e.parent)) list.add(e.parent);
  }
  return list;
}

@riverpod
bool selectedPath(Ref ref, String folder) {
  return ref.watch(fileListProvider).every((e) {
    if (e.parent == folder) return e.checked;
    return true;
  });
}

@riverpod
class CSVData extends _$CSVData {
  @override
  List<CSVRenameInfo> build() => [];
  void update(List<CSVRenameInfo> value) => state = value;
  void updateOne(int index, String flag, String value) =>
      state = state.map((e) {
        if (state.indexOf(e) == index) {
          flag == 'A' ? e.nameA = value : e.nameB = value;
        }
        return e;
      }).toList();
}

@riverpod
class AdvanceMenuSelectedList extends _$AdvanceMenuSelectedList {
  @override
  List<AdvanceMenuModel> build() => [];
  void add(AdvanceMenuModel group) => state = [...state, group];
  void addAll(List<AdvanceMenuModel> group) => state = [...state, ...group];
  void remove(AdvanceMenuModel group) =>
      state = state.where((e) => e != group).toList();
  void one(AdvanceMenuModel group) => state = [group];
  void clear() => state = [];
}
