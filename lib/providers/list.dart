import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/sort.dart';
import 'package:once_power/models/file_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/sort_enum.dart';
import 'package:once_power/providers/select.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'file.dart';

part 'list.g.dart';

@riverpod
List<FileInfo> sortList(Ref ref) {
  final type = ref.watch(fileSortTypeProvider);
  final list = ref.watch(fileListProvider);

  List<FileInfo> sortedList;

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
      sortedList = [...list]
        ..sort((a, b) => a.extension.compareTo(b.extension));
      break;
    case SortType.typeDescending:
      sortedList = [...list]
        ..sort((a, b) => b.extension.compareTo(a.extension));
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
List<FileClassify> classifyList(Ref ref) {
  List<FileClassify> classifyList = [];
  for (var e in ref.watch(fileListProvider)) {
    if (!classifyList.contains(e.type)) classifyList.add(e.type);
  }
  return classifyList;
}

@riverpod
Map<FileClassify, List<String>> extensionListMap(Ref ref) {
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

// @riverpod
// class GroupList extends _$GroupList {
//   @override
//   List<String> build() => [];
//   void add(String group) {
//     state = [...state, group];
//     print(state);
//   }
// }
