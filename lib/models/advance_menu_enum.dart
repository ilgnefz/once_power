import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';

enum AdvanceType { delete, add, replace }

extension AdvanceTypeExtension on AdvanceType {
  String get label {
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

enum MatchContent { first, last, all, front, back, position }

extension MatchLocationExtension on MatchContent {
  String get label {
    switch (this) {
      case MatchContent.first:
        return S.current.first;
      case MatchContent.last:
        return S.current.last;
      case MatchContent.all:
        return S.current.all;
      case MatchContent.position:
        return '';
      case MatchContent.front:
        return S.current.front;
      case MatchContent.back:
        return S.current.back;
    }
  }

  bool get isFirst => this == MatchContent.first;
  bool get isLast => this == MatchContent.last;
  bool get isAll => this == MatchContent.all;
  bool get isPosition => this == MatchContent.position;
  bool get isFront => this == MatchContent.front;
  bool get isBack => this == MatchContent.back;
}

enum AddType {
  text,
  serialNumber,
  random,
  parentsName,
  width,
  height,
  extension,
  date,
  metaData,
}

extension AddTypeExtension on AddType {
  String get label {
    switch (this) {
      case AddType.text:
        return S.current.text;
      case AddType.serialNumber:
        return S.current.serial;
      case AddType.parentsName:
        return S.current.parentsName;
      case AddType.extension:
        return S.current.extension;
      case AddType.date:
        return '';
      case AddType.random:
        return S.current.random;
      case AddType.width:
        return S.current.width;
      case AddType.height:
        return S.current.height;
      case AddType.metaData:
        return S.current.metaData;
    }
  }

  bool get isText => this == AddType.text;
  bool get isSerialNumber => this == AddType.serialNumber;
  bool get isParentsName => this == AddType.parentsName;
  bool get isExtension => this == AddType.extension;
  bool get isDate => this == AddType.date;
  bool get isRandom => this == AddType.random;
  bool get isWidth => this == AddType.width;
  bool get isHeight => this == AddType.height;
  bool get isMetaData => this == AddType.metaData;
}

enum AddPosition { before, after }

extension AddPositionExtension on AddPosition {
  String get label {
    switch (this) {
      case AddPosition.before:
        return S.current.addBefore;
      case AddPosition.after:
        return S.current.addAfter;
    }
  }

  bool get isBefore => this == AddPosition.before;
  bool get isAfter => this == AddPosition.after;
}

enum CaseType {
  noConversion,
  uppercase,
  lowercase,
  toggleCase,
  traditional,
  simplified
}

extension CaseTypeExtension on CaseType {
  String get label {
    switch (this) {
      case CaseType.uppercase:
        return S.current.uppercase;
      case CaseType.lowercase:
        return S.current.lowercase;
      case CaseType.toggleCase:
        return S.current.toggleCase;
      case CaseType.noConversion:
        return S.current.noConversion;
      case CaseType.traditional:
        return S.current.traditional;
      case CaseType.simplified:
        return S.current.simplified;
    }
  }

  bool get isNoConversion => this == CaseType.noConversion;
  bool get isUppercase => this == CaseType.uppercase;
  bool get isLowercase => this == CaseType.lowercase;
  bool get isToggleCase => this == CaseType.toggleCase;
  bool get isTraditional => this == CaseType.traditional;
  bool get isSimplified => this == CaseType.simplified;
}

enum ReplaceMode { normal, format }

extension ReplaceModeExtension on ReplaceMode {
  String get label {
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
  String get label {
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

enum DistinguishType { none, folder, file, extension, group }

extension DistinguishTypeExtension on DistinguishType {
  String get label {
    switch (this) {
      case DistinguishType.folder:
        return S.current.folder;
      case DistinguishType.file:
        return S.current.fileType;
      case DistinguishType.extension:
        return S.current.extension;
      case DistinguishType.none:
        return S.current.disable;
      case DistinguishType.group:
        return S.current.group;
    }
  }

  bool get isFolder => this == DistinguishType.folder;
  bool get isFile => this == DistinguishType.file;
  bool get isExtension => this == DistinguishType.extension;
  bool get isGroup => this == DistinguishType.group;
  bool get isNone => this == DistinguishType.none;
}

enum FillPosition { front, back }

extension CompletePositionExtension on FillPosition {
  String get label {
    switch (this) {
      case FillPosition.front:
        return S.current.fillFront;
      case FillPosition.back:
        return S.current.fillBack;
    }
  }

  bool get isFront => this == FillPosition.front;
  bool get isBack => this == FillPosition.back;
}

enum DateSplitType { none, chinese, space, dash, dot, underscore }

extension DateSplitTypeExtension on DateSplitType {
  String get label {
    switch (this) {
      case DateSplitType.none:
        return S.current.none;
      case DateSplitType.chinese:
        return '年月日';
      case DateSplitType.space:
        return S.current.space;
      case DateSplitType.dash:
        return '-';
      case DateSplitType.dot:
        return '.';
      case DateSplitType.underscore:
        return '_';
    }
  }
}

enum FileMetaData { title, artist, album, year }

extension FileMetaDataExtension on FileMetaData {
  String get label {
    switch (this) {
      case FileMetaData.title:
        return S.current.title;
      case FileMetaData.artist:
        return S.current.artist;
      case FileMetaData.album:
        return S.current.album;
      case FileMetaData.year:
        return S.current.year;
    }
  }
}
