import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constants/l10n.dart';

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
