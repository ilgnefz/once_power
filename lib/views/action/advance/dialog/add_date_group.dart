import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/enums/week.dart';
import 'package:once_power/widgets/common/dropdown_text.dart';

class AddDateGroup extends ConsumerWidget {
  const AddDateGroup({
    super.key,
    required this.date,
    required this.dateSplit,
    required this.timeSplit,
    required this.weekdayStyle,
    required this.dateChange,
    required this.dateSplitChange,
    required this.timeSplitChange,
    required this.weekdayStyleChange,
  });

  final DateType date;
  final DateSplitType dateSplit;
  final TimeSplitType timeSplit;
  final WeekdayStyle weekdayStyle;
  final void Function(DateType?) dateChange;
  final void Function(DateSplitType?) dateSplitChange;
  final void Function(TimeSplitType?) timeSplitChange;
  final void Function(WeekdayStyle?) weekdayStyleChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    TextStyle? textStyle = theme.dropdownMenuTheme.textStyle;
    return Row(
      spacing: 2,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextDropdown(
          items: DateType.values
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
          value: date,
          onChanged: dateChange,
        ),
        TextDropdown(
          items: DateSplitType.values
              .map(
                (item) => DropdownMenuItem(
                  key: ValueKey(item),
                  value: item,
                  child: Text(item.label, style: textStyle),
                ),
              )
              .toList(),
          color: theme.popupMenuTheme.surfaceTintColor,
          value: dateSplit,
          onChanged: dateSplitChange,
        ),
        TextDropdown(
          items: TimeSplitType.values
              .map(
                (item) => DropdownMenuItem(
                  key: ValueKey(item),
                  value: item,
                  child: Text(item.label, style: textStyle),
                ),
              )
              .toList(),
          color: theme.popupMenuTheme.surfaceTintColor,
          value: timeSplit,
          onChanged: timeSplitChange,
        ),
        TextDropdown(
          items: WeekdayStyle.values
              .map(
                (item) => DropdownMenuItem(
                  key: ValueKey(item),
                  value: item,
                  child: Text(item.label, style: textStyle),
                ),
              )
              .toList(),
          color: theme.popupMenuTheme.surfaceTintColor,
          width: 104,
          value: weekdayStyle,
          onChanged: weekdayStyleChange,
        ),
      ],
    );
  }
}
