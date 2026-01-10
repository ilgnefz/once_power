import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/enums/date.dart';
import 'package:once_power/widgets/common/digit_input.dart';
import 'package:once_power/widgets/common/dropdown_text.dart';

class IntervalGroup extends StatelessWidget {
  const IntervalGroup({
    super.key,
    required this.diffType,
    required this.interval,
    required this.dateType,
    required this.onDiffTypeChanged,
    required this.onIntervalChanged,
    required this.onDateTypeChanged,
  });

  final DateDiffType diffType;
  final int interval;
  final DateTimeUnit dateType;
  final void Function(DateDiffType?) onDiffTypeChanged;
  final void Function(int) onIntervalChanged;
  final void Function(DateTimeUnit?) onDateTypeChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    TextStyle? textStyle = theme.dropdownMenuTheme.textStyle;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppNum.spaceSmall,
        children: [
          Text('${tr(AppL10n.dateInterval)}:'),
          TextDropdown(
            items: DateDiffType.values
                .map(
                  (item) => DropdownMenuItem(
                    key: ValueKey(item),
                    value: item,
                    child: Text(item.label, style: textStyle),
                  ),
                )
                .toList(),
            color: theme.popupMenuTheme.surfaceTintColor,
            value: diffType,
            width: 70,
            onChanged: onDiffTypeChanged,
          ),
          Expanded(
            child: DigitInput(
              value: interval,
              unit: null,
              onChanged: onIntervalChanged,
            ),
          ),
          TextDropdown(
            items: DateTimeUnit.values
                .map(
                  (item) => DropdownMenuItem(
                    key: ValueKey(item),
                    value: item,
                    child: Text(item.label, style: textStyle),
                  ),
                )
                .toList(),
            color: theme.popupMenuTheme.surfaceTintColor,
            value: dateType,
            width: 75,
            onChanged: onDateTypeChanged,
          ),
        ],
      ),
    );
  }
}
