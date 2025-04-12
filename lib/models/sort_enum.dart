import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';

enum SortType {
  defaultSort,
  nameAscending,
  nameDescending,
  dateAscending,
  dateDescending,
  typeAscending,
  typeDescending,
  checkAscending,
  checkDescending,
  sizeAscending,
  sizeDescending,
  groupAscending,
  groupDescending,
  folderAscending,
  folderDescending
}

extension SortTypeExtension on SortType {
  String get icon {
    switch (this) {
      case SortType.defaultSort:
        return AppIcons.sort;
      case SortType.nameAscending:
        return AppIcons.nameAscending;
      case SortType.nameDescending:
        return AppIcons.nameDescending;
      case SortType.dateAscending:
        return AppIcons.dateAscending;
      case SortType.dateDescending:
        return AppIcons.dateDescending;
      case SortType.typeAscending:
        return AppIcons.typeAscending;
      case SortType.typeDescending:
        return AppIcons.typeDescending;
      case SortType.checkAscending:
        return AppIcons.checkAscending;
      case SortType.checkDescending:
        return AppIcons.checkDescending;
      case SortType.sizeAscending:
        return AppIcons.sizeAscending;
      case SortType.sizeDescending:
        return AppIcons.sizeDescending;
      case SortType.groupAscending:
        return AppIcons.groupAscending;
      case SortType.groupDescending:
        return AppIcons.groupDescending;
      case SortType.folderAscending:
        return AppIcons.folderAscending;
      case SortType.folderDescending:
        return AppIcons.folderDescending;
    }
  }

  String get label {
    switch (this) {
      case SortType.defaultSort:
        return S.current.defaultSort;
      case SortType.nameDescending:
        return S.current.nameDescending;
      case SortType.nameAscending:
        return S.current.nameAscending;
      case SortType.dateDescending:
        return S.current.dateDescending;
      case SortType.dateAscending:
        return S.current.dateAscending;
      case SortType.typeDescending:
        return S.current.typeDescending;
      case SortType.typeAscending:
        return S.current.typeAscending;
      case SortType.checkDescending:
        return S.current.checkDescending;
      case SortType.checkAscending:
        return S.current.checkAscending;
      case SortType.sizeDescending:
        return S.current.sizeDescending;
      case SortType.sizeAscending:
        return S.current.sizeAscending;
      case SortType.groupDescending:
        return S.current.groupDescending;
      case SortType.groupAscending:
        return S.current.groupAscending;
      case SortType.folderDescending:
        return S.current.folderDescending;
      case SortType.folderAscending:
        return S.current.folderAscending;
    }
  }
}
