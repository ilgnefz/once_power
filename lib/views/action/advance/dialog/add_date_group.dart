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
    required this.dateChange,
    required this.dateSplitChange,
  });

  final DateType date;
  final DateSplitType dateSplit;
  final void Function(DateType?) dateChange;
  final void Function(DateSplitType?) dateSplitChange;

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
          width: 102,
          color: theme.popupMenuTheme.surfaceTintColor,
          value: dateSplit,
          onChanged: dateSplitChange,
        ),
      ],
    );
  }
}
