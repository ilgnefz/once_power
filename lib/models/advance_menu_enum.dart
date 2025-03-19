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

enum MatchLocation { first, last, all, position }

extension MatchLocationExtension on MatchLocation {
  String get label {
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

enum AddType { text, serialNumber, parentsName, extension, random }

extension AddTypeExtension on AddType {
  String get label {
    switch (this) {
      case AddType.text:
        return S.current.text;
      case AddType.serialNumber:
        return S.current.serialNumber;
      case AddType.parentsName:
        return S.current.parentsName;
      case AddType.extension:
        return S.current.extension;
      case AddType.random:
        return S.current.random;
    }
  }

  bool get isText => this == AddType.text;
  bool get isSerialNumber => this == AddType.serialNumber;
  bool get isParentsName => this == AddType.parentsName;
  bool get isExtension => this == AddType.extension;
  bool get isRandom => this == AddType.random;
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

enum CaseType { noConversion, uppercase, lowercase, toggleCase }

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
    }
  }

  bool get isNoConversion => this == CaseType.noConversion;
  bool get isUppercase => this == CaseType.uppercase;
  bool get isLowercase => this == CaseType.lowercase;
  bool get isToggleCase => this == CaseType.toggleCase;
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

enum DistinguishType { folder, file, extension, none }

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
    }
  }

  bool get isFolder => this == DistinguishType.folder;
  bool get isFile => this == DistinguishType.file;
  bool get isExtension => this == DistinguishType.extension;
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
