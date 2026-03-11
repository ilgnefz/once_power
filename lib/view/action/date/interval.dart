import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/model/date.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/digit_input.dart';
import 'package:once_power/widget/common/text_dropdown.dart';

class IntervalGroup extends StatelessWidget {
  const IntervalGroup({
    super.key,
    required this.dateProperty,
    required this.provider,
  });

  final DateProperty dateProperty;
  final FileDateProperty provider;

  @override
  Widget build(BuildContext context) {
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
                  (item) => DropdownItem(
                    key: ValueKey(item),
                    value: item,
                    height: AppNum.widgetHeight,
                    child: BaseText(item.label),
                  ),
                )
                .toList(),
            // color: theme.popupMenuTheme.surfaceTintColor,
            value: dateProperty.diffType,
            width: 70,
            onChanged: (value) =>
                provider.update(dateProperty.copyWith(diffType: value)),
          ),
          DigitInput(
            value: dateProperty.interval,
            unit: '',
            onChanged: (value) =>
                provider.update(dateProperty.copyWith(interval: value)),
          ),
          TextDropdown(
            items: DateTimeUnit.values
                .map(
                  (item) => DropdownItem(
                    key: ValueKey(item),
                    value: item,
                    height: AppNum.widgetHeight,
                    child: BaseText(item.label),
                  ),
                )
                .toList(),
            // color: theme.popupMenuTheme.surfaceTintColor,
            value: dateProperty.dateUnit,
            width: 75,
            onChanged: (value) =>
                provider.update(dateProperty.copyWith(dateUnit: value)),
          ),
        ],
      ),
    );
  }
}
