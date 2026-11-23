import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constant/l10n.dart';

enum DateType { created, modified, accessed, exif, earliest, latest }

extension DateTypeExtension on DateType {
  String get label {
    switch (this) {
      case DateType.created:
        return tr(AppL10n.created);
      case DateType.modified:
        return tr(AppL10n.modified);
      case DateType.accessed:
        return tr(AppL10n.accessed);
      case DateType.exif:
        return tr(AppL10n.captured);
      case DateType.earliest:
        return tr(AppL10n.earliest);
      case DateType.latest:
        return tr(AppL10n.latest);
    }
  }

  bool get isCreated => this == DateType.created;
  bool get isModified => this == DateType.modified;
  bool get isAccessed => this == DateType.accessed;
  bool get isExif => this == DateType.exif;
  bool get isEarliest => this == DateType.earliest;
  bool get isLatest => this == DateType.latest;
}

enum WeekdayStyle {
  none(-1),
  chineseShort(0),
  chineseLong(1),
  japanese(2),
  english(3);

  final int value;
  const WeekdayStyle(this.value);
}

extension WeekdayStyleExtension on WeekdayStyle {
  String get label {
    switch (this) {
      case WeekdayStyle.none:
        return tr(AppL10n.dateSeparateHidden);
      case WeekdayStyle.chineseShort:
        return '周一';
      case WeekdayStyle.chineseLong:
        return '星期一';
      case WeekdayStyle.japanese:
        return '月曜日';
      case WeekdayStyle.english:
        return 'Monday';
    }
  }

  bool get isNone => this == WeekdayStyle.none;
}

final List<List<String>> weekdayNames = [
  ['周一', '星期一', '月曜日', 'Monday'],
  ['周二', '星期二', '火曜日', 'Tuesday'],
  ['周三', '星期三', '水曜日', 'Wednesday'],
  ['周四', '星期四', '木曜日', 'Thursday'],
  ['周五', '星期五', '金曜日', 'Friday'],
  ['周六', '星期六', '土曜日', 'Saturday'],
  ['周日', '星期日', '日曜日', 'Sunday'],
];
