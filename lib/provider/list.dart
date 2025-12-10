import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/enums/sort.dart';
import 'package:once_power/models/advance.dart';
import 'package:once_power/models/csv.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'file.dart';

part 'list.g.dart';

@riverpod
List<FileInfo> sortList(Ref ref) {
  SortType type = ref.watch(currentSortProvider);
  List<FileInfo> list = ref.watch(fileListProvider);
  List<FileInfo> sortedList = [];

  switch (type) {
    case SortType.nameAscending:
      sortedList = splitSortList(list, false);
      break;
    case SortType.nameDescending:
      sortedList = splitSortList(list, true);
      break;
    case SortType.dateAscending:
      sortedList = [...list]..sort((a, b) {
          int result = a.createdDate.compareTo(b.createdDate);
          return result == 0 ? a.name.compareTo(b.name) : result;
        });
      break;
    case SortType.dateDescending:
      sortedList = [...list]..sort((a, b) {
          int result = b.createdDate.compareTo(a.createdDate);
          return result == 0 ? b.name.compareTo(a.name) : result;
        });
      break;
    case SortType.typeAscending:
      sortedList = [...list]..sort((a, b) => a.ext.compareTo(b.ext));
      break;
    case SortType.typeDescending:
      sortedList = [...list]..sort((a, b) => b.ext.compareTo(a.ext));
      break;
    case SortType.checkAscending:
      sortedList = [...list]..sort((a, b) {
          if (a.checked == b.checked) return 0;
          return a.checked ? -1 : 1;
        });
      break;
    case SortType.checkDescending:
      sortedList = [...list]..sort((a, b) {
          if (a.checked == b.checked) return 0;
          return b.checked ? -1 : 1;
        });
      break;
    case SortType.sizeAscending:
      sortedList = [...list]..sort((a, b) {
          if (a.size == b.size) return 0;
          return a.size.compareTo(b.size);
        });
      break;
    case SortType.sizeDescending:
      sortedList = [...list]..sort((a, b) {
          if (a.size == b.size) return 0;
          return b.size.compareTo(a.size);
        });
      break;
    case SortType.groupAscending:
      sortedList = [...list]..sort((a, b) {
          if (a.group == b.group) return 0;
          return a.group.compareTo(b.group);
        });
      break;
    case SortType.groupDescending:
      sortedList = [...list]..sort((a, b) {
          if (a.group == b.group) return 0;
          return b.group.compareTo(a.group);
        });
      break;
    case SortType.folderAscending:
      sortedList = [...list]..sort((a, b) {
          if (a.parent == b.parent) return 0;
          return a.parent.compareTo(b.parent);
        });
      break;
    case SortType.folderDescending:
      sortedList = [...list]..sort((a, b) {
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

@riverpod
class CSVData extends _$CSVData {
  @override
  List<CsvRenameInfo> build() => [];
  void update(List<CsvRenameInfo> value) => state = value;
  void updateOne(int index, String flag, String value) =>
      state = state.map((e) {
        if (state.indexOf(e) == index) {
          flag == 'A' ? e.nameA = value : e.nameB = value;
        }
        return e;
      }).toList();
}

@riverpod
List<FileClassify> classifyList(Ref ref) {
  List<FileClassify> classifyList = [];
  for (FileInfo e in ref.watch(fileListProvider)) {
    if (!classifyList.contains(e.type)) classifyList.add(e.type);
  }
  return classifyList;
}

@riverpod
Map<FileClassify, List<String>> extensionListMap(Ref ref) {
  Map<FileClassify, List<String>> extMap = {};
  for (var e in ref.watch(fileListProvider)) {
    if (!extMap.containsKey(e.type)) {
      extMap[e.type] = [e.ext];
    } else {
      if (!extMap[e.type]!.contains(e.ext)) {
        extMap[e.type]!.add(e.ext);
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
    if (e.ext == ext) return e.checked;
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
