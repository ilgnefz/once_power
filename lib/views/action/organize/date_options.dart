import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/enums/organize.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/common/dropdown_text.dart';

final List<DateType> _dateTypes = [
  DateType.createdDate,
  DateType.modifiedDate,
  DateType.accessedDate,
  DateType.exifDate
];

class DateOptions extends ConsumerWidget {
  const DateOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    TextStyle? textStyle = theme.dropdownMenuTheme.textStyle;

    return Padding(
      padding: EdgeInsets.only(
        left: AppNum.padding,
        top: AppNum.spaceSmall,
        bottom: AppNum.spaceSmall,
      ),
      child: Row(
        spacing: 2,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextDropdown(
            items: _dateTypes
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
            value: ref.watch(organizeDateProvider),
            onChanged: (value) =>
                ref.read(organizeDateProvider.notifier).update(value!),
          ),
          TextDropdown(
            items: DateFormat.values
                .map(
                  (item) => DropdownMenuItem(
                    key: ValueKey(item),
                    value: item,
                    child: Text(item.label, style: textStyle),
                  ),
                )
                .toList(),
            color: theme.popupMenuTheme.surfaceTintColor,
            value: ref.watch(organizeDateFormatProvider),
            onChanged: (value) =>
                ref.read(organizeDateFormatProvider.notifier).update(value!),
          ),
          TextDropdown(
            items: DateFormatSeparate.values
                .map(
                  (item) => DropdownMenuItem(
                    key: ValueKey(item),
                    value: item,
                    child: Text(item.label, style: textStyle),
                  ),
                )
                .toList(),
            color: theme.popupMenuTheme.surfaceTintColor,
            value: ref.watch(organizeDateSeparateProvider),
            onChanged: (value) =>
                ref.read(organizeDateSeparateProvider.notifier).update(value!),
          ),
        ],
      ),
    );
  }
}
