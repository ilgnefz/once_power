import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/text_dropdown.dart';

class AddDateGroup extends StatelessWidget {
  const AddDateGroup({
    super.key,
    required this.date,
    required this.onDateChange,
    required this.dateStyle,
    required this.onDateStyleChange,
    required this.weekdayStyle,
    required this.onWeekdayStyleChange,
    required this.timeStyle,
    required this.onTimeStyleChange,
  });

  final DateType date;
  final void Function(DateType) onDateChange;
  final DateStyle dateStyle;
  final void Function(DateStyle) onDateStyleChange;
  final WeekdayStyle weekdayStyle;
  final void Function(WeekdayStyle) onWeekdayStyleChange;
  final TimeStyle timeStyle;
  final void Function(TimeStyle) onTimeStyleChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppNum.spaceSmall,
      children: [
        TextDropdown<DateType>(
          items: DateType.values
              .map(
                (item) => DropdownItem(
                  key: ValueKey(item),
                  value: item,
                  height: AppNum.dropdownMenu,
                  child: BaseText(item.label),
                ),
              )
              .toList(),
          value: date,
          width: 100,
          onChanged: onDateChange,
        ),
        TextDropdown<DateStyle>(
          items: DateStyle.values
              .map(
                (item) => DropdownItem(
                  key: ValueKey(item),
                  value: item,
                  height: AppNum.dropdownMenu,
                  child: BaseText(item.label),
                ),
              )
              .toList(),
          value: dateStyle,
          onChanged: onDateStyleChange,
        ),
        TextDropdown<WeekdayStyle>(
          items: WeekdayStyle.values
              .map(
                (item) => DropdownItem(
                  key: ValueKey(item),
                  value: item,
                  height: AppNum.dropdownMenu,
                  child: BaseText(item.label),
                ),
              )
              .toList(),
          value: weekdayStyle,
          onChanged: onWeekdayStyleChange,
        ),
        TextDropdown<TimeStyle>(
          items: TimeStyle.values
              .map(
                (item) => DropdownItem(
                  key: ValueKey(item),
                  value: item,
                  height: AppNum.dropdownMenu,
                  child: BaseText(item.label),
                ),
              )
              .toList(),
          value: timeStyle,
          onChanged: onTimeStyleChange,
        ),
      ],
    );
  }
}
