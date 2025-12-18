import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/widgets/common/dropdown_text.dart';

class AddDateGroup extends ConsumerWidget {
  const AddDateGroup({
    super.key,
    required this.date,
    required this.dateSplit,
    required this.timeSplit,
    required this.dateChange,
    required this.dateSplitChange,
    required this.timeSplitChange,
  });

  final DateType date;
  final DateSplitType dateSplit;
  final TimeSplitType timeSplit;
  final void Function(DateType?) dateChange;
  final void Function(DateSplitType?) dateSplitChange;
  final void Function(TimeSplitType?) timeSplitChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    TextStyle? textStyle = theme.dropdownMenuTheme.textStyle;
    return Row(
      spacing: 4,
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
      ],
    );
  }
}
