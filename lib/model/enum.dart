import 'package:flutter/material.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';

enum FunctionMode { replace, reserve, advance, organize }

extension FunctionModeExtension on FunctionMode {
  bool get isOrganize => this == FunctionMode.organize;
  bool get isReserve => this == FunctionMode.reserve;
  bool get isAdvance => this == FunctionMode.advance;
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
  nameAscending,
  nameDescending,
  dateAscending,
  dateDescending,
  typeAscending,
  typeDescending,
  checkAscending,
  checkDescending
}

extension SortTypeExtension on SortType {
  String get value {
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
    }
  }
}

enum LanguageType {
  english('English'),
  chinese('中文');

  final String value;
  const LanguageType(this.value);
}

enum AdvanceType { delete, add, replace }

extension AdvanceTypeExtension on AdvanceType {
  String get value {
    switch (this) {
      case AdvanceType.delete:
        return S.current.delete;
      case AdvanceType.add:
        return S.current.add;
      case AdvanceType.replace:
        return S.current.replace;
    }
  }

  Color get color {
    switch (this) {
      case AdvanceType.delete:
        return Colors.red;
      case AdvanceType.add:
        return Colors.green;
      case AdvanceType.replace:
        return Colors.blue;
    }
  }

  bool get isDelete => this == AdvanceType.delete;
  bool get isAdd => this == AdvanceType.add;
  bool get isReplace => this == AdvanceType.replace;
}

enum MatchLocation { first, last, all, position }

extension MatchLocationExtension on MatchLocation {
  String get value {
    switch (this) {
      case MatchLocation.first:
        return S.current.first;
      case MatchLocation.last:
        return S.current.last;
      case MatchLocation.all:
        return S.current.all;
      case MatchLocation.position:
        return '';
    }
  }

  bool get isFirst => this == MatchLocation.first;
  bool get isLast => this == MatchLocation.last;
  bool get isAll => this == MatchLocation.all;
  bool get isPosition => this == MatchLocation.position;
}

enum AddType { text, serialNumber, parentsName }

extension AddTypeExtension on AddType {
  String get value {
    switch (this) {
      case AddType.text:
        return S.current.text;
      case AddType.serialNumber:
        return S.current.serialNumber;
      case AddType.parentsName:
        return S.current.parentsName;
    }
  }

  bool get isText => this == AddType.text;
  bool get isSerialNumber => this == AddType.serialNumber;
  bool get isParentsName => this == AddType.parentsName;
}

enum AddPosition { before, after, position }

extension AddPositionExtension on AddPosition {
  String get value {
    switch (this) {
      case AddPosition.before:
        return S.current.addBefore;
      case AddPosition.after:
        return S.current.addAfter;
      case AddPosition.position:
        return '';
    }
  }

  bool get isBefore => this == AddPosition.before;
  bool get isAfter => this == AddPosition.after;
  bool get isPosition => this == AddPosition.position;
}

enum CaseType { noConversion, uppercase, lowercase, toggleCase }

extension CaseTypeExtension on CaseType {
  String get value {
    switch (this) {
      case CaseType.uppercase:
        return S.current.uppercase;
      case CaseType.lowercase:
        return S.current.lowercase;
      case CaseType.toggleCase:
        return S.current.toggleCase;
      case CaseType.noConversion:
        return S.current.noConversion;
    }
  }

  bool get isNoConversion => this == CaseType.noConversion;
  bool get isUppercase => this == CaseType.uppercase;
  bool get isLowercase => this == CaseType.lowercase;
  bool get isToggleCase => this == CaseType.toggleCase;
}

enum ReplaceMode { normal, format }

extension ReplaceModeExtension on ReplaceMode {
  String get value {
    switch (this) {
      case ReplaceMode.normal:
        return S.current.normal;
      case ReplaceMode.format:
        return S.current.format;
    }
  }

  bool get isNormal => this == ReplaceMode.normal;
  bool get isFormat => this == ReplaceMode.format;
}

enum DeleteType {
  digit,
  capitalLetter,
  lowercaseLetters,
  nonLetter,
  punctuation,
  space
}

extension DeleteTypeExtension on DeleteType {
  String get value {
    switch (this) {
      case DeleteType.digit:
        return S.current.digit;
      case DeleteType.capitalLetter:
        return S.current.capitalLetter;
      case DeleteType.lowercaseLetters:
        return S.current.lowercaseLetters;
      case DeleteType.nonLetter:
        return S.current.nonLetter;
      case DeleteType.punctuation:
        return S.current.punctuation;
      case DeleteType.space:
        return S.current.space;
    }
  }
}

enum MovePosition { first, center, last, idle }
