import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/add.dart';
import 'package:once_power/enmu/date.dart';
import 'package:once_power/view/action/advanced/dialog/add_date_separate.dart';
import 'package:once_power/view/action/advanced/dialog/add_date_type.dart';
import 'package:once_power/widget/action/dialog_item.dart';

class AddDateGroup extends StatelessWidget {
  const AddDateGroup({
    super.key,
    required this.selected,
    required this.date,
    required this.onDateChange,
    required this.dateStyle,
    required this.onDateStyleChange,
    required this.weekdayStyle,
    required this.onWeekdayStyleChange,
    required this.timeStyle,
    required this.onTimeStyleChange,
    required this.dateSeparate,
    required this.onDateSeparateChange,
    required this.custom,
    required this.onCustomChange,
  });

  final bool selected;
  final DateType date;
  final ValueChanged<DateType> onDateChange;
  final DateStyle dateStyle;
  final ValueChanged<DateStyle> onDateStyleChange;
  final WeekdayStyle weekdayStyle;
  final ValueChanged<WeekdayStyle> onWeekdayStyleChange;
  final TimeStyle timeStyle;
  final ValueChanged<TimeStyle> onTimeStyleChange;
  final DateSeparate dateSeparate;
  final void Function(DateSeparate) onDateSeparateChange;
  final String custom;
  final void Function(String) onCustomChange;

  @override
  Widget build(BuildContext context) {
    return SelectedBox(
      selected: selected,
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppNumber.spaceMedium,
        children: [
          AddDateType(
            date: date,
            onDateChange: onDateChange,
            dateStyle: dateStyle,
            onDateStyleChange: onDateStyleChange,
            weekdayStyle: weekdayStyle,
            onWeekdayStyleChange: onWeekdayStyleChange,
            timeStyle: timeStyle,
            onTimeStyleChange: onTimeStyleChange,
          ),
          AddDateSeparate(
            dateSeparate: dateSeparate,
            onDateSeparateChange: onDateSeparateChange,
            custom: custom,
            onCustomChange: onCustomChange,
          ),
        ],
      ),
    );
  }
}
