import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/organize.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/text_dropdown.dart';

final List<DateType> _dateTypes = [
  DateType.createdDate,
  DateType.modifiedDate,
  DateType.accessedDate,
  DateType.exifDate,
];

class DateOptions extends ConsumerWidget {
  const DateOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    TextStyle? textStyle = theme.dropdownMenuTheme.textStyle;

    return Padding(
      padding: .only(left: AppNum.padding, bottom: AppNum.spaceSmall),
      child: Row(
        spacing: 2,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextDropdown(
            items: _dateTypes
                .map(
                  (item) => DropdownItem(
                    key: ValueKey(item),
                    value: item,
                    height: AppNum.widgetHeight,
                    child: BaseText(item.label),
                  ),
                )
                .toList(),
            width: 104,
            // color: theme.popupMenuTheme.surfaceTintColor,
            value: ref.watch(organizeDateProvider),
            onChanged: (value) =>
                ref.read(organizeDateProvider.notifier).update(value),
          ),
          TextDropdown(
            items: DateFormat.values
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
            value: ref.watch(organizeDateFormatProvider),
            onChanged: (value) =>
                ref.read(organizeDateFormatProvider.notifier).update(value),
          ),
          TextDropdown(
            items: DateFormatSeparate.values
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
            value: ref.watch(organizeDateSeparateProvider),
            onChanged: (value) =>
                ref.read(organizeDateSeparateProvider.notifier).update(value),
          ),
        ],
      ),
    );
  }
}
