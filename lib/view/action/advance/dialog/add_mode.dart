import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/view/action/advance/dialog/add_date_group.dart';
import 'package:once_power/view/action/advance/dialog/add_meta.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/common/digit_input.dart';
import 'package:once_power/widget/common/radio.dart';

class AddModeGroup extends StatelessWidget {
  const AddModeGroup({
    super.key,
    required this.type,
    required this.onChanged,
    required this.length,
    required this.onLengthChanged,
    required this.date,
    required this.onDateChange,
    required this.dateStyle,
    required this.onDateStyleChange,
    required this.weekdayStyle,
    required this.onWeekdayStyleChange,
    required this.timeStyle,
    required this.onTimeStyleChange,
    required this.prefix,
    required this.onPrefixChanged,
    required this.metaData,
    required this.onMetaDataChange,
    required this.suffix,
    required this.onSuffixChanged,
  });

  final AddMode type;
  final void Function(AddMode) onChanged;
  final int length;
  final void Function(int) onLengthChanged;
  final DateType date;
  final void Function(DateType) onDateChange;
  final DateStyle dateStyle;
  final void Function(DateStyle) onDateStyleChange;
  final WeekdayStyle weekdayStyle;
  final void Function(WeekdayStyle) onWeekdayStyleChange;
  final TimeStyle timeStyle;
  final void Function(TimeStyle) onTimeStyleChange;
  final String prefix;
  final void Function(String) onPrefixChanged;
  final MetaDataType metaData;
  final void Function(MetaDataType) onMetaDataChange;
  final String suffix;
  final void Function(String) onSuffixChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<AddMode>(
      groupValue: type,
      onChanged: (value) => onChanged(value!),
      child: DialogOption(
        title: tr(AppL10n.advanceAddType),
        padding: const .only(top: 4),
        spacing: AppNum.spaceMedium,
        runSpacing: AppNum.spaceMedium,
        alignment: WrapAlignment.spaceBetween,
        children: AddMode.values.map((e) {
          switch (e) {
            case AddMode.random:
              return EasyRadio(
                label: e.label,
                value: e,
                trailing: DigitInput(
                  width: 104,
                  value: length,
                  unit: tr(AppL10n.renameLength),
                  min: 1,
                  onChanged: onLengthChanged,
                ),
              );
            case AddMode.date:
              return EasyRadio(
                label: e.label,
                value: e,
                space: 0,
                trailing: AddDateGroup(
                  date: date,
                  onDateChange: onDateChange,
                  dateStyle: dateStyle,
                  onDateStyleChange: onDateStyleChange,
                  weekdayStyle: weekdayStyle,
                  onWeekdayStyleChange: onWeekdayStyleChange,
                  timeStyle: timeStyle,
                  onTimeStyleChange: onTimeStyleChange,
                ),
              );
            case AddMode.metaData:
              return EasyRadio(
                label: e.label,
                value: e,
                trailing: AddMetaGroup(
                  prefix: prefix,
                  onPrefixChanged: onPrefixChanged,
                  metaData: metaData,
                  onMetaDataChange: onMetaDataChange,
                  suffix: suffix,
                  onSuffixChanged: onSuffixChanged,
                ),
              );
            default:
              return EasyRadio(label: e.label, value: e);
          }
        }).toList(),
      ),
    );
  }
}
