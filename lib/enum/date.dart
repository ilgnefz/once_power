import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/const/l10n.dart';

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
        return tr(AppL10n.eDateCreate);
      case DateType.modifiedDate:
        return tr(AppL10n.eDateModify);
      case DateType.accessedDate:
        return tr(AppL10n.eDateAccess);
      case DateType.exifDate:
        return tr(AppL10n.eDateCapture);
      case DateType.earliestDate:
        return tr(AppL10n.eDateEarliest);
      case DateType.latestDate:
        return tr(AppL10n.eDateLatest);
    }
  }

  bool get isCreatedDate => this == DateType.createdDate;
  bool get isModifiedDate => this == DateType.modifiedDate;
  bool get isAccessedDate => this == DateType.accessedDate;
  bool get isExifDate => this == DateType.exifDate;
  bool get isEarliestDate => this == DateType.earliestDate;
  bool get isLatestDate => this == DateType.latestDate;
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
        return tr(AppL10n.eSplitHidden);
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

// class WeekdayFormatter {
//   // 星期名称映射表
//   static const Map<WeekdayStyle, List<String>> _weekdayNames = {
//     WeekdayStyle.chineseShort: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
//     WeekdayStyle.chineseLong: ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'],
//     WeekdayStyle.japanese: ['月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日', '日曜日'],
//     WeekdayStyle.english: [
//       'Monday',
//       'Tuesday',
//       'Wednesday',
//       'Thursday',
//       'Friday',
//       'Saturday',
//       'Sunday'
//     ],
//   };
//
//   /// 根据日期和格式获取星期名称
//   static String format(DateTime date, WeekdayStyle format) {
//     final weekdayIndex = date.weekday - 1; // DateTime.weekday 1=周一，转换为0索引
//     return _weekdayNames[format]![weekdayIndex];
//   }
// }

enum DateDiffType { add, sub }

extension DiffTypeExtension on DateDiffType {
  String get label {
    switch (this) {
      case DateDiffType.add:
        return tr(AppL10n.eDiffIncrement);
      case DateDiffType.sub:
        return tr(AppL10n.eDiffDecrement);
    }
  }

  bool get isAdd => this == DateDiffType.add;
  bool get isSub => this == DateDiffType.sub;
}

enum DateTimeUnit { year, month, day, hour, minute, second }

extension DateTimeUnitExtension on DateTimeUnit {
  String get label {
    switch (this) {
      case DateTimeUnit.year:
        return tr(AppL10n.eDateTimeYear);
      case DateTimeUnit.month:
        return tr(AppL10n.eDateTimeMonth);
      case DateTimeUnit.day:
        return tr(AppL10n.eDateTimeDay);
      case DateTimeUnit.hour:
        return tr(AppL10n.eDateTimeHour);
      case DateTimeUnit.minute:
        return tr(AppL10n.eDateTimeMinute);
      case DateTimeUnit.second:
        return tr(AppL10n.eDateTimeSecond);
    }
  }

  bool get isYear => this == DateTimeUnit.year;
  bool get isMonth => this == DateTimeUnit.month;
  bool get isDay => this == DateTimeUnit.day;
  bool get isHour => this == DateTimeUnit.hour;
  bool get isMinute => this == DateTimeUnit.minute;
  bool get isSecond => this == DateTimeUnit.second;
}

extension DateTimeCalculator on DateTime {
  DateTime addSingleUnit(DateTimeUnit unit, int n) {
    if (n == 0) return this; // 无需修改，直接返回原对象

    switch (unit) {
      case DateTimeUnit.year:
        // 注意：若原日期是2月29日（闰年），加减到平年时，会自动转为2月28日
        return DateTime(
          year + n,
          month,
          day,
          hour,
          minute,
          second,
          millisecond,
          microsecond,
        );
      case DateTimeUnit.month:
        return add(Duration(days: 0)).copyWith(month: month + n);
      case DateTimeUnit.day:
        return add(Duration(days: n));
      case DateTimeUnit.hour:
        return add(Duration(hours: n));
      case DateTimeUnit.minute:
        return add(Duration(minutes: n));
      case DateTimeUnit.second:
        return add(Duration(seconds: n));
    }
  }
}
