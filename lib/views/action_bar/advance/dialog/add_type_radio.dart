import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/models/two_re_enum.dart';
import 'package:once_power/views/action_bar/advance/dialog/add_date_group.dart';
import 'package:once_power/widgets/action_bar/dialog_option.dart';
import 'package:once_power/widgets/action_bar/digit_input.dart';
import 'package:once_power/widgets/action_bar/easy_radio.dart';

import 'add_meta_data.dart';

class AddTypeRadio extends StatelessWidget {
  const AddTypeRadio({
    super.key,
    required this.type,
    required this.len,
    required this.date,
    required this.typeChanged,
    required this.randomLenChange,
    required this.dateChange,
    required this.dateSplit,
    required this.dateSplitChange,
    required this.metaData,
    required this.metaDataChange,
  });

  final AddType type;
  final int len;
  final DateType date;
  final DateSplitType dateSplit;
  final FileMetaData metaData;
  final void Function(AddType) typeChanged;
  final void Function(DateSplitType?) dateSplitChange;
  final void Function(int) randomLenChange;
  final void Function(DateType?) dateChange;
  final void Function(FileMetaData?) metaDataChange;

  @override
  Widget build(BuildContext context) {
    return DialogOption(
      title: '${S.of(context).addType}: ',
      padding: const EdgeInsets.only(top: 4.0),
      spacing: AppNum.mediumG,
      runSpacing: AppNum.smallG,
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        ...AddType.values.map((e) {
          return EasyRadio(
            label: e.label,
            value: e,
            groupValue: type,
            onChanged: (value) => typeChanged(value!),
            space: e.isDate ? 0 : AppNum.operateG,
            trailing: () {
              if (e.isRandom) {
                return SizedBox(
                  width: 104,
                  child: DigitInput(
                    value: len,
                    label: S.of(context).digits,
                    min: 1,
                    onChanged: randomLenChange,
                  ),
                );
              }
              if (e.isDate) {
                return AddDateGroup(
                  date: date,
                  dateSplit: dateSplit,
                  dateChange: dateChange,
                  dateSplitChange: dateSplitChange,
                );
              }
              if (e.isMetaData) {
                return AddMetaData(
                  metaData: metaData,
                  mateDataChange: metaDataChange,
                );
              }
              return null;
            }(),
          );
        }),
      ],
    );
  }
}
