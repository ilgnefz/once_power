import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/enums/week.dart';
import 'package:once_power/widgets/action/dialog_option.dart';
import 'package:once_power/widgets/base/easy_radio.dart';
import 'package:once_power/widgets/common/click_icon.dart';
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
    required this.timeSplit,
    required this.weekdayStyle,
    required this.dateSplitChange,
    required this.timeSplitChange,
    required this.weekdayStyleChange,
    required this.metaData,
    required this.metaDataChange,
  });

  final AddType type;
  final int len;
  final DateType date;
  final DateSplitType dateSplit;
  final TimeSplitType timeSplit;
  final WeekdayStyle weekdayStyle;
  final FileMetaData metaData;
  final void Function(AddType) typeChanged;
  final void Function(int) randomLenChange;
  final void Function(DateType?) dateChange;
  final void Function(DateSplitType?) dateSplitChange;
  final void Function(TimeSplitType?) timeSplitChange;
  final void Function(WeekdayStyle?) weekdayStyleChange;
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
                  timeSplit: timeSplit,
                  weekdayStyle: weekdayStyle,
                  dateChange: dateChange,
                  dateSplitChange: dateSplitChange,
                  timeSplitChange: timeSplitChange,
                  weekdayStyleChange: weekdayStyleChange,
                );
              }
              if (e.isMetaData) {
                return Row(
                  children: [
                    AddMetaData(
                      metaData: metaData,
                      mateDataChange: metaDataChange,
                    ),
                    const SizedBox(width: 4.0),
                    if (metaData.isLocation)
                      RepaintBoundary(
                        child: Transform.rotate(
                          angle: 45,
                          child: ClickIcon(
                            icon: Icons.key_rounded,
                            onPressed: () => showKeyInput(context),
                          ),
                        ),
                      ),
                  ],
                );
              }
            }(),
          );
        }),
      ],
    );
  }
}
