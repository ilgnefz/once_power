import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/advance_add.dart';
import 'package:once_power/view/action/advance/dialog/add_date_group.dart';
import 'package:once_power/view/action/advance/dialog/add_meta.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/common/digit_input.dart';
import 'package:once_power/widget/common/radio.dart';

class AddModeGroup extends StatelessWidget {
  const AddModeGroup({
    super.key,
    required this.mode,
    required this.onModeChanged,
    required this.randomLength,
    required this.onRandomLengthChanged,
    required this.advanceDate,
    required this.onDateTypeChange,
    required this.onDateStyleChange,
    required this.onWeekdayStyleChange,
    required this.onTimeStyleChange,
    required this.metaData,
    required this.onPrefixChanged,
    required this.onMetaDataChange,
    required this.onSuffixChanged,
  });

  final AddMode mode;
  final void Function(AddMode) onModeChanged;
  final int randomLength;
  final void Function(int) onRandomLengthChanged;
  final AdvanceDate advanceDate;
  final void Function(DateType) onDateTypeChange;
  final void Function(DateStyle) onDateStyleChange;
  final void Function(WeekdayStyle) onWeekdayStyleChange;
  final void Function(TimeStyle) onTimeStyleChange;
  final AdvanceMetaData metaData;
  final void Function(String) onPrefixChanged;
  final void Function(MetaDataType) onMetaDataChange;
  final void Function(String) onSuffixChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<AddMode>(
      groupValue: mode,
      onChanged: (value) => onModeChanged(value!),
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
                  value: randomLength,
                  unit: tr(AppL10n.renameLength),
                  min: 1,
                  onChanged: onRandomLengthChanged,
                ),
              );
            case AddMode.date:
              return EasyRadio(
                label: e.label,
                value: e,
                space: 0,
                trailing: AddDateGroup(
                  date: advanceDate.type,
                  onDateChange: onDateTypeChange,
                  dateStyle: advanceDate.dateStyle,
                  onDateStyleChange: onDateStyleChange,
                  weekdayStyle: advanceDate.weekdayStyle,
                  onWeekdayStyleChange: onWeekdayStyleChange,
                  timeStyle: advanceDate.timeStyle,
                  onTimeStyleChange: onTimeStyleChange,
                ),
              );
            case AddMode.metaData:
              return EasyRadio(
                label: e.label,
                value: e,
                trailing: AddMetaGroup(
                  prefix: metaData.prefix,
                  onPrefixChanged: onPrefixChanged,
                  metaData: metaData.type,
                  onMetaDataChange: onMetaDataChange,
                  suffix: metaData.suffix,
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
