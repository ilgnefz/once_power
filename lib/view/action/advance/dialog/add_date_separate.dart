import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/text_dropdown.dart';
import 'package:once_power/widget/common/input_field.dart';

class AddDateSeparate extends StatelessWidget {
  const AddDateSeparate({
    super.key,
    required this.dateSeparate,
    required this.onDateSeparateChange,
    required this.custom,
    required this.onCustomChange,
  });

  final DateSeparateType dateSeparate;
  final void Function(DateSeparateType) onDateSeparateChange;
  final String custom;
  final void Function(String) onCustomChange;

  @override
  Widget build(BuildContext context) {
    return DialogOption(
      title: tr(AppL10n.advanceDateSeparate),
      padding: const .only(top: 4, right: 4),
      spacing: AppNum.spaceSmall,
      children: [
        TextDropdown<DateSeparateType>(
          items: DateSeparateType.values
              .map(
                (item) => DropdownItem(
                  key: ValueKey(item),
                  value: item,
                  height: AppNum.dropdownMenu,
                  child: BaseText(item.label),
                ),
              )
              .toList(),
          value: dateSeparate,
          width: 96,
          onChanged: onDateSeparateChange,
        ),
        SizedBox(
          width: 256,
          child: InputField(
            text: custom,
            hintText: tr(AppL10n.eSplitCustomTip),
            onChanged: onCustomChange,
          ),
        ),
      ],
    );
  }
}
