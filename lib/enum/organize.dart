import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/const/l10n.dart';

enum OrganizeMode { normal, group, type, top, date }

extension OrganizeModeExtension on OrganizeMode {
  bool get isNormal => this == OrganizeMode.normal;
  bool get isGroup => this == OrganizeMode.group;
  bool get isType => this == OrganizeMode.type;
  bool get isTop => this == OrganizeMode.top;
  bool get isDate => this == OrganizeMode.date;
}

enum DateFormat { ymd, ym, y }

extension DateFormatExtension on DateFormat {
  String get label {
    switch (this) {
      case DateFormat.ymd:
        return tr(AppL10n.eFormatYMD);
      case DateFormat.ym:
        return tr(AppL10n.eFormatYM);
      case DateFormat.y:
        return tr(AppL10n.eFormatY);
    }
  }
}

enum DateFormatSeparate { none, chinese, chineseSpace, space, dash, underline }

extension DateFormatSeparateExtension on DateFormatSeparate {
  String get label {
    switch (this) {
      case DateFormatSeparate.none:
        return tr(AppL10n.eSplitNone);
      case DateFormatSeparate.chinese:
        return '年月日';
      case DateFormatSeparate.chineseSpace:
        return '年 月 日';
      case DateFormatSeparate.space:
        return tr(AppL10n.eSplitSpace);
      case DateFormatSeparate.dash:
        return '-';
      case DateFormatSeparate.underline:
        return '_';
    }
  }
}
