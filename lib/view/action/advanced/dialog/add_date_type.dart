import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/add.dart';
import 'package:once_power/enmu/date.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/base/dropdown.dart';

class AddDateType extends StatelessWidget {
  const AddDateType({
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
    return DialogItem(
      title: context.tr(AppL10n.dateType),
      spacing: AppNumber.spaceSmall,
      children: [
        const SizedBox.shrink(),
        EasyTextDropdown<DateType>(
          items: DateType.values.map((e) {
            return TextDropdownItem(e, label: e.label);
          }).toList(),
          value: date,
          onChanged: onDateChange,
        ),
        EasyTextDropdown<DateStyle>(
          items: DateStyle.values.map((e) {
            return TextDropdownItem(e, label: e.label);
          }).toList(),
          value: dateStyle,
          onChanged: onDateStyleChange,
        ),
        EasyTextDropdown<WeekdayStyle>(
          items: WeekdayStyle.values.map((e) {
            return TextDropdownItem(e, label: e.label);
          }).toList(),
          value: weekdayStyle,
          width: 98,
          onChanged: onWeekdayStyleChange,
        ),
        EasyTextDropdown<TimeStyle>(
          items: TimeStyle.values.map((e) {
            return TextDropdownItem(e, label: e.label);
          }).toList(),
          value: timeStyle,
          width: 98,
          onChanged: onTimeStyleChange,
        ),
      ],
    );
  }
}
