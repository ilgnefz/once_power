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

enum MatchContent { number, last, all }

extension MatchContentExtension on MatchContent {
  String get label {
    switch (this) {
      case MatchContent.number:
        return tr(AppL10n.advanceDi);
      case MatchContent.last:
        return tr(AppL10n.eMatchLast);
      case MatchContent.all:
        return tr(AppL10n.eMatchAll);
    }
  }

  bool get isNumber => this == MatchContent.number;
  bool get isLast => this == MatchContent.last;
  bool get isAll => this == MatchContent.all;
}

enum MatchPosition { self, front, behind }

extension MatchLocationExtension on MatchPosition {
  String get label {
    switch (this) {
      case MatchPosition.self:
        return tr(AppL10n.advanceSelf);
      case MatchPosition.front:
        return tr(AppL10n.advanceFront);
      case MatchPosition.behind:
        return tr(AppL10n.advanceBehind);
    }
  }

  bool get isSelf => this == MatchPosition.self;
  bool get isFront => this == MatchPosition.front;
  bool get isBehind => this == MatchPosition.behind;
}

enum DeleteMode { input, type, position, extension }

extension DeleteModeExtension on DeleteMode {
  String get label {
    switch (this) {
      case DeleteMode.input:
        return tr(AppL10n.eDeleteInput);
      case DeleteMode.type:
        return tr(AppL10n.eDeleteType);
      case DeleteMode.extension:
        return tr(AppL10n.eDeleteExtension);
      case DeleteMode.position:
        return '';
    }
  }

  bool get isInput => this == DeleteMode.input;
  bool get isType => this == DeleteMode.type;
  bool get isExtension => this == DeleteMode.extension;
  bool get isPosition => this == DeleteMode.position;
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

enum AddMode {
  text,
  indexes,
  random,
  folder,
  width,
  height,
  extension,
  group,
  date,
  metaData,
}

extension AddModeExtension on AddMode {
  String get label {
    switch (this) {
      case AddMode.text:
        return tr(AppL10n.eAddText);
      case AddMode.indexes:
        return tr(AppL10n.eAddIndex);
      case AddMode.random:
        return tr(AppL10n.eAddRandom);
      case AddMode.folder:
        return tr(AppL10n.eAddFolder);
      case AddMode.width:
        return tr(AppL10n.eAddWidth);
      case AddMode.height:
        return tr(AppL10n.eAddHeight);
      case AddMode.extension:
        return tr(AppL10n.eAddExt);
      case AddMode.date:
        return '';
      case AddMode.group:
        return tr(AppL10n.eAddGroup);
      case AddMode.metaData:
        return tr(AppL10n.eAddMeta);
    }
  }

  bool get isText => this == AddMode.text;
  bool get isIndex => this == AddMode.indexes;
  bool get isFolder => this == AddMode.folder;
  bool get isExtension => this == AddMode.extension;
  bool get isDate => this == AddMode.date;
  bool get isRandom => this == AddMode.random;
  bool get isWidth => this == AddMode.width;
  bool get isHeight => this == AddMode.height;
  bool get isMetaData => this == AddMode.metaData;
  bool get isGroup => this == AddMode.group;
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

enum DistinctionType { none, file, extension, date, folder, group }

extension DistinctionTypeExtension on DistinctionType {
  String get label {
    switch (this) {
      case DistinctionType.none:
        return tr(AppL10n.eDistNone);
      case DistinctionType.date:
        return tr(AppL10n.eDistDate);
      case DistinctionType.folder:
        return tr(AppL10n.eDistFolder);
      case DistinctionType.file:
        return tr(AppL10n.eDistFile);
      case DistinctionType.extension:
        return tr(AppL10n.eDistExtension);
      case DistinctionType.group:
        return tr(AppL10n.eDistGroup);
    }
  }

  bool get isDate => this == DistinctionType.date;
  bool get isFolder => this == DistinctionType.folder;
  bool get isFile => this == DistinctionType.file;
  bool get isExtension => this == DistinctionType.extension;
  bool get isGroup => this == DistinctionType.group;
  bool get isNone => this == DistinctionType.none;
}

enum AddPosition { behind, front, end, interval }

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

enum ConvertType { uppercase, lowercase, toggleCase, traditional, simplified }

extension ConvertTypeExtension on ConvertType {
  String get label {
    switch (this) {
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

  bool get isUppercase => this == ConvertType.uppercase;
  bool get isLowercase => this == ConvertType.lowercase;
  bool get isToggleCase => this == ConvertType.toggleCase;
  bool get isTraditional => this == ConvertType.traditional;
  bool get isSimplified => this == ConvertType.simplified;
}

enum ReplaceMode { normal, convert, format, position, separator }

extension ReplaceModeExtension on ReplaceMode {
  String get label {
    switch (this) {
      case ReplaceMode.normal:
        return tr(AppL10n.eReplaceNormal);
      case ReplaceMode.convert:
        return tr(AppL10n.eReplaceConvert);
      case ReplaceMode.separator:
        return tr(AppL10n.advanceWord);
      case ReplaceMode.format:
        return tr(AppL10n.eReplaceFormat);
      case ReplaceMode.position:
        return '';
    }
  }

  bool get isNormal => this == ReplaceMode.normal;
  bool get isConvert => this == ReplaceMode.convert;
  bool get isSeparator => this == ReplaceMode.separator;
  bool get isFormat => this == ReplaceMode.format;
  bool get isPosition => this == ReplaceMode.position;
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
