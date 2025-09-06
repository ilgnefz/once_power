import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/widgets/action/dialog_option.dart';
import 'package:once_power/widgets/base/easy_radio.dart';
import 'package:once_power/widgets/common/digit_input.dart';

import 'add_date_group.dart';
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
      title: '${tr(AppL10n.advanceAddType)}: ',
      padding: const EdgeInsets.only(top: 4.0),
      spacing: AppNum.spaceMedium,
      runSpacing: AppNum.spaceSmall,
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        ...AddType.values.map((e) {
          return EasyRadio(
            label: e.label,
            value: e,
            groupValue: type,
            onChanged: (value) => typeChanged(value!),
            space: e.isDate ? 0 : AppNum.operateSpace,
            trailing: () {
              if (e.isRandom) {
                return SizedBox(
                  width: 104,
                  child: DigitInput(
                    value: len,
                    unit: tr(AppL10n.advanceDigits),
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
