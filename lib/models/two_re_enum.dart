import 'package:once_power/generated/l10n.dart';

enum ReplaceType { match, before, after, between }

extension RemoveTypeExtension on ReplaceType {
  String get label {
    switch (this) {
      case ReplaceType.match:
        return S.current.match;
      case ReplaceType.before:
        return S.current.before;
      case ReplaceType.between:
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
  String get label {
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
  accessedDate,
  exifDate,
  earliestDate,
  latestDate,
}

extension DateTypeExtension on DateType {
  String get label {
    switch (this) {
      case DateType.createdDate:
        return S.current.createdDate;
      case DateType.modifiedDate:
        return S.current.modifiedDate;
      case DateType.accessedDate:
        return S.current.accessedDate;
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
  bool get isAccessedDate => this == DateType.accessedDate;
  bool get isExifDate => this == DateType.exifDate;
  bool get isEarliestDate => this == DateType.earliestDate;
  bool get isLatestDate => this == DateType.latestDate;
}
