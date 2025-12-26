import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constants/l10n.dart';

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

enum DateFormatSeparate { none, chinese, space, dash, underline }

extension DateFormatSeparateExtension on DateFormatSeparate {
  String get label {
    switch (this) {
      case DateFormatSeparate.none:
        return tr(AppL10n.eSplitNone);
      case DateFormatSeparate.chinese:
        return '年月日';
      case DateFormatSeparate.space:
        return tr(AppL10n.eSplitSpace);
      case DateFormatSeparate.dash:
        return '-';
      case DateFormatSeparate.underline:
        return '_';
    }
  }
}
