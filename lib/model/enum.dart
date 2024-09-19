import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';

enum FunctionMode { replace, reserve, organize }

extension FunctionModeExtension on FunctionMode {
  bool get isOrganize => this == FunctionMode.organize;
  bool get isReserve => this == FunctionMode.reserve;
  bool get isReplace => this == FunctionMode.replace;
}

enum ReplaceType { match, before, after, middle }

extension RemoveTypeExtension on ReplaceType {
  String get value {
    switch (this) {
      case ReplaceType.match:
        return S.current.match;
      case ReplaceType.before:
        return S.current.before;
      case ReplaceType.middle:
        return S.current.between;
      case ReplaceType.after:
        return S.current.after;
    }
  }
}

enum ReserveType {
  capitalLetter,
  lowercaseLetter,
  nonLetter,
  digit,
  punctuation
}

extension ReservedTypeExtension on ReserveType {
  String get value {
    switch (this) {
      case ReserveType.capitalLetter:
        return 'ABC';
      case ReserveType.lowercaseLetter:
        return 'abc';
      case ReserveType.nonLetter:
        return '中あ조བོད';
      case ReserveType.digit:
        return '123';
      case ReserveType.punctuation:
        return '!.?';
    }
  }
}

enum DateType {
  createdDate,
  modifiedDate,
  exifDate,
  earliestDate,
  latestDate,
}

extension DateTypeExtension on DateType {
  String get value {
    switch (this) {
      case DateType.createdDate:
        return S.current.createdDate;
      case DateType.modifiedDate:
        return S.current.modifiedDate;
      case DateType.exifDate:
        return S.current.exifDate;
      case DateType.earliestDate:
        return S.current.earliestDate;
      case DateType.latestDate:
        return S.current.latestDate;
    }
  }

  bool get isCreatedDate => this == DateType.createdDate;
  bool get isModifiedDate => this == DateType.modifiedDate;
  bool get isExifDate => this == DateType.exifDate;
  bool get isEarliestDate => this == DateType.earliestDate;
  bool get isLatestDate => this == DateType.latestDate;
}

enum FileUploadType { prefix, suffix }

enum FileClassify { image, video, doc, audio, folder, zip, other }

extension FileClassifyExtension on FileClassify {
  String get value {
    switch (this) {
      case FileClassify.image:
        return S.current.image;
      case FileClassify.video:
        return S.current.video;
      case FileClassify.doc:
        return S.current.document;
      case FileClassify.audio:
        return S.current.audio;
      case FileClassify.folder:
        return S.current.folder;
      case FileClassify.zip:
        return S.current.zip;
      case FileClassify.other:
        return S.current.other;
    }
  }

  bool get isFolder => this == FileClassify.folder;
  bool get isImage => this == FileClassify.image;
  bool get isVideo => this == FileClassify.video;
  bool get isDoc => this == FileClassify.doc;
  bool get isAudio => this == FileClassify.audio;
  bool get isZip => this == FileClassify.zip;
  bool get isOther => this == FileClassify.other;
}

enum SortType {
  defaultSort,
  nameDescending,
  nameAscending,
  dateDescending,
  dateAscending,
  typeDescending,
  typeAscending,
  checkDescending,
  checkAscending
}

extension SortTypeExtension on SortType {
  String get value {
    switch (this) {
      case SortType.defaultSort:
        return AppIcons.sort;
      case SortType.nameDescending:
        return AppIcons.nameDescending;
      case SortType.nameAscending:
        return AppIcons.nameAscending;
      case SortType.dateDescending:
        return AppIcons.dateDescending;
      case SortType.dateAscending:
        return AppIcons.dateAscending;
      case SortType.typeDescending:
        return AppIcons.typeDescending;
      case SortType.typeAscending:
        return AppIcons.typeAscending;
      case SortType.checkDescending:
        return AppIcons.checkDescending;
      case SortType.checkAscending:
        return AppIcons.checkAscending;
    }
  }
}

enum LanguageType {
  english('English'),
  chinese('中文');

  final String value;
  const LanguageType(this.value);
}
