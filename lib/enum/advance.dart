import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';

enum AdvanceType { delete, add, replace }

extension AdvanceTypeExtension on AdvanceType {
  String get label {
    switch (this) {
      case AdvanceType.delete:
        return tr(AppL10n.eAdvanceDelete);
      case AdvanceType.add:
        return tr(AppL10n.eAdvanceAdd);
      case AdvanceType.replace:
        return tr(AppL10n.eAdvanceReplace);
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

enum MatchContent { first, last, all, number, front, behind, position }

extension MatchLocationExtension on MatchContent {
  String get label {
    switch (this) {
      case MatchContent.first:
        return tr(AppL10n.eMatchFirst);
      case MatchContent.last:
        return tr(AppL10n.eMatchLast);
      case MatchContent.all:
        return tr(AppL10n.eMatchAll);
      case MatchContent.number:
        return tr(AppL10n.advanceDi);
      case MatchContent.position:
        return '';
      case MatchContent.front:
        return tr(AppL10n.eMatchFront);
      case MatchContent.behind:
        return tr(AppL10n.eMatchBehind);
    }
  }

  bool get isFirst => this == MatchContent.first;
  bool get isLast => this == MatchContent.last;
  bool get isAll => this == MatchContent.all;
  bool get isNumber => this == MatchContent.number;
  bool get isPosition => this == MatchContent.position;
  bool get isFront => this == MatchContent.front;
  bool get isBehind => this == MatchContent.behind;
}

enum DeleteType { digit, capital, lowercase, nonLetter, punctuation, space }

extension DeleteTypeExtension on DeleteType {
  String get label {
    switch (this) {
      case DeleteType.digit:
        return tr(AppL10n.eDeleteDigit);
      case DeleteType.capital:
        return tr(AppL10n.eDeleteCapital);
      case DeleteType.lowercase:
        return tr(AppL10n.eDeleteLower);
      case DeleteType.nonLetter:
        return tr(AppL10n.eDeleteNonLetter);
      case DeleteType.punctuation:
        return tr(AppL10n.eDeletePunctuation);
      case DeleteType.space:
        return tr(AppL10n.eDeleteSpace);
    }
  }
}

enum AddType {
  text,
  serial,
  random,
  folder,
  width,
  height,
  extension,
  group,
  date,
  metaData,
}

extension AddTypeExtension on AddType {
  String get label {
    switch (this) {
      case AddType.text:
        return tr(AppL10n.eAddText);
      case AddType.serial:
        return tr(AppL10n.eAddSerial);
      case AddType.random:
        return tr(AppL10n.eAddRandom);
      case AddType.folder:
        return tr(AppL10n.eAddFolder);
      case AddType.width:
        return tr(AppL10n.eAddWidth);
      case AddType.height:
        return tr(AppL10n.eAddHeight);
      case AddType.extension:
        return tr(AppL10n.eAddExt);
      case AddType.date:
        return '';
      case AddType.group:
        return tr(AppL10n.eAddGroup);
      case AddType.metaData:
        return tr(AppL10n.eAddMeta);
    }
  }

  bool get isText => this == AddType.text;
  bool get isSerial => this == AddType.serial;
  bool get isFolder => this == AddType.folder;
  bool get isExtension => this == AddType.extension;
  bool get isDate => this == AddType.date;
  bool get isRandom => this == AddType.random;
  bool get isWidth => this == AddType.width;
  bool get isHeight => this == AddType.height;
  bool get isMetaData => this == AddType.metaData;
  bool get isGroup => this == AddType.group;
}

enum DateStyle { hidden, none, chinese, space, dash, underscore, dot }

extension DateStyleExtension on DateStyle {
  String get label {
    switch (this) {
      case DateStyle.hidden:
        return tr(AppL10n.eSplitHidden);
      case DateStyle.none:
        return tr(AppL10n.eSplitNone);
      case DateStyle.chinese:
        return '年月日';
      case DateStyle.space:
        return tr(AppL10n.eSplitSpace);
      case DateStyle.dash:
        return '-';
      case DateStyle.dot:
        return '.';
      case DateStyle.underscore:
        return '_';
    }
  }
}

enum TimeStyle { hidden, none, chinese, english, space, dash, underscore, dot }

extension TimeStyleExtension on TimeStyle {
  String get label {
    switch (this) {
      case TimeStyle.hidden:
        return tr(AppL10n.eSplitHidden);
      case TimeStyle.none:
        return tr(AppL10n.eSplitNone);
      case TimeStyle.chinese:
        return '时分秒';
      case TimeStyle.english:
        return 'hms';
      case TimeStyle.space:
        return tr(AppL10n.eSplitSpace);
      case TimeStyle.dash:
        return '-';
      case TimeStyle.dot:
        return '.';
      case TimeStyle.underscore:
        return '_';
    }
  }
}

enum DateSeparateType { none, space, dash, underscore, dot, custom }

extension DateSeparateTypeExtension on DateSeparateType {
  String get label {
    switch (this) {
      case DateSeparateType.none:
        return tr(AppL10n.eSplitNone);
      case DateSeparateType.space:
        return tr(AppL10n.eSplitSpace);
      case DateSeparateType.dash:
        return '-';
      case DateSeparateType.dot:
        return '.';
      case DateSeparateType.underscore:
        return '_';
      case DateSeparateType.custom:
        return tr(AppL10n.eSplitCustom);
    }
  }

  String get value {
    switch (this) {
      case DateSeparateType.none:
        return '';
      case DateSeparateType.space:
        return ' ';
      case DateSeparateType.dash:
        return '-';
      case DateSeparateType.dot:
        return '.';
      case DateSeparateType.underscore:
        return '_';
      case DateSeparateType.custom:
        return tr(AppL10n.eSplitCustom);
    }
  }

  bool get isCustom => this == DateSeparateType.custom;
}

enum DistinguishType { none, folder, file, extension, group, date }

extension DistinguishTypeExtension on DistinguishType {
  String get label {
    switch (this) {
      case DistinguishType.none:
        return tr(AppL10n.eDistNone);
      case DistinguishType.date:
        return tr(AppL10n.eDistDate);
      case DistinguishType.folder:
        return tr(AppL10n.eDistFolder);
      case DistinguishType.file:
        return tr(AppL10n.eDistFile);
      case DistinguishType.extension:
        return tr(AppL10n.eDistExt);
      case DistinguishType.group:
        return tr(AppL10n.eDistGroup);
    }
  }

  bool get isDate => this == DistinguishType.date;
  bool get isFolder => this == DistinguishType.folder;
  bool get isFile => this == DistinguishType.file;
  bool get isExtension => this == DistinguishType.extension;
  bool get isGroup => this == DistinguishType.group;
  bool get isNone => this == DistinguishType.none;
}

enum AddPosition { front, behind, end, interval }

extension AddPositionExtension on AddPosition {
  String get label {
    switch (this) {
      case AddPosition.front:
        return tr(AppL10n.eMatchFront);
      case AddPosition.behind:
        return tr(AppL10n.eMatchBehind);
      case AddPosition.end:
        return tr(AppL10n.eMatchEnd);
      case AddPosition.interval:
        return tr(AppL10n.eMatchInterval);
    }
  }

  bool get isBefore => this == AddPosition.front;
  bool get isAfter => this == AddPosition.behind;
  bool get isEnd => this == AddPosition.end;
  bool get isInterval => this == AddPosition.interval;
}

enum ConvertType {
  noConversion,
  uppercase,
  lowercase,
  toggleCase,
  traditional,
  simplified,
}

extension ConvertTypeExtension on ConvertType {
  String get label {
    switch (this) {
      case ConvertType.noConversion:
        return tr(AppL10n.eConvertNo);
      case ConvertType.uppercase:
        return tr(AppL10n.eConvertUpper);
      case ConvertType.lowercase:
        return tr(AppL10n.eConvertLower);
      case ConvertType.toggleCase:
        return tr(AppL10n.eConvertToggle);
      case ConvertType.traditional:
        return tr(AppL10n.eConvertTradition);
      case ConvertType.simplified:
        return tr(AppL10n.eConvertSimplified);
    }
  }

  bool get isNoConversion => this == ConvertType.noConversion;
  bool get isUppercase => this == ConvertType.uppercase;
  bool get isLowercase => this == ConvertType.lowercase;
  bool get isToggleCase => this == ConvertType.toggleCase;
  bool get isTraditional => this == ConvertType.traditional;
  bool get isSimplified => this == ConvertType.simplified;
}

enum ReplaceMode { normal, format }

extension ReplaceModeExtension on ReplaceMode {
  String get label {
    switch (this) {
      case ReplaceMode.normal:
        return tr(AppL10n.eReplaceNormal);
      case ReplaceMode.format:
        return tr(AppL10n.eReplaceFormat);
    }
  }

  bool get isNormal => this == ReplaceMode.normal;
  bool get isFormat => this == ReplaceMode.format;
}

enum FillPosition { front, behind }

extension FillPositionExtension on FillPosition {
  String get label {
    switch (this) {
      case FillPosition.front:
        return tr(AppL10n.eFillFront);
      case FillPosition.behind:
        return tr(AppL10n.eFillBehind);
    }
  }

  bool get isFront => this == FillPosition.front;
  bool get isBehind => this == FillPosition.behind;
}

enum MovePosition { first, center, last, idle }
