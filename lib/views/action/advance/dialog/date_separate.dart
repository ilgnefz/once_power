import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/widgets/action/dialog_option.dart';
import 'package:once_power/widgets/common/dropdown_text.dart';

import 'dialog_base_input.dart';

class DateSeparateView extends StatelessWidget {
  const DateSeparateView({
    super.key,
    required this.separateType,
    required this.custom,
    required this.separateChange,
    required this.customChange,
  });

  final DateSeparateType separateType;
  final String custom;
  final ValueChanged<DateSeparateType?> separateChange;
  final ValueChanged<String> customChange;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    TextStyle? textStyle = theme.dropdownMenuTheme.textStyle;
    return DialogOption(
      title: '${tr(AppL10n.advanceDateSeparate)}:',
      padding: EdgeInsets.only(top: 4.0, right: AppNum.spaceSmall),
      spacing: AppNum.spaceMedium,
      children: [
        TextDropdown(
          items: DateSeparateType.values
              .map(
                (item) => DropdownMenuItem(
                  key: ValueKey(item),
                  value: item,
                  child: Text(item.label, style: textStyle),
                ),
              )
              .toList(),
          width: 104,
          color: theme.popupMenuTheme.surfaceTintColor,
          value: separateType,
          onChanged: separateChange,
        ),
        SizedBox(
          width: 200,
          child: DialogBaseInput(
            value: custom,
            hintText: tr(AppL10n.eSplitCustomTip),
            onChanged: customChange,
          ),
        ),
      ],
    );
  }
}
