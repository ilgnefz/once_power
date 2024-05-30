import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';

enum FunctionMode { replace, reserve, organize }

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

enum RemoveType { match, before, after, middle }

extension RemoveTypeExtension on RemoveType {
  String get value {
    switch (this) {
      case RemoveType.match:
        return S.current.match;
      case RemoveType.before:
        return S.current.before;
      case RemoveType.middle:
        return S.current.between;
      case RemoveType.after:
        return S.current.after;
    }
  }
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

enum FileClassify { image, video, text, audio, folder, zip, other }

extension FileClassifyExtension on FileClassify {
  String get value {
    switch (this) {
      case FileClassify.image:
        return S.current.image;
      case FileClassify.video:
        return S.current.video;
      case FileClassify.text:
        return S.current.text;
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
}

enum FileUploadType { prefix, suffix }

enum NotificationType { failure, success }

enum LanguageType {
  english('English'),
  chinese('中文');

  final String value;
  const LanguageType(this.value);
}
