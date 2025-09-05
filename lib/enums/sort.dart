import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';

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
  folderDescending,
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
        return tr(AppL10n.contentSortDefault);
      case SortType.nameAscending:
        return tr(AppL10n.contentSortNameA);
      case SortType.nameDescending:
        return tr(AppL10n.contentSortNameD);
      case SortType.dateAscending:
        return tr(AppL10n.contentSortDateA);
      case SortType.dateDescending:
        return tr(AppL10n.contentSortDateD);
      case SortType.typeAscending:
        return tr(AppL10n.contentSortTypeA);
      case SortType.typeDescending:
        return tr(AppL10n.contentSortTypeD);
      case SortType.checkAscending:
        return tr(AppL10n.contentSortCheckA);
      case SortType.checkDescending:
        return tr(AppL10n.contentSortCheckD);
      case SortType.sizeAscending:
        return tr(AppL10n.contentSortSizeA);
      case SortType.sizeDescending:
        return tr(AppL10n.contentSortSizeD);
      case SortType.groupAscending:
        return tr(AppL10n.contentSortGroupA);
      case SortType.groupDescending:
        return tr(AppL10n.contentSortGroupD);
      case SortType.folderAscending:
        return tr(AppL10n.contentSortFolderA);
      case SortType.folderDescending:
        return tr(AppL10n.contentSortFolderD);
    }
  }
}
