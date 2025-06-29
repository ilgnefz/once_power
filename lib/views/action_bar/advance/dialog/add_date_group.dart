import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/models/two_re_enum.dart';
import 'package:once_power/widgets/common/easy_text_dropdown.dart';

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
    final theme = Theme.of(context);
    final textStyle = TextStyle(color: theme.textTheme.labelMedium?.color);
    return Row(
      spacing: 4,
      mainAxisSize: MainAxisSize.min,
      children: [
        EasyTextDropdown(
          items: DateType.values
              .map((item) => DropdownMenuItem(
                    key: ValueKey(item),
                    value: item,
                    child: Text(item.label, style: textStyle),
                  ))
              .toList(),
          width: 102,
          color: theme.popupMenuTheme.surfaceTintColor,
          value: date,
          onChanged: dateChange,
        ),
        EasyTextDropdown(
          items: DateSplitType.values
              .map((item) => DropdownMenuItem(
                    key: ValueKey(item),
                    value: item,
                    child: Text(item.label, style: textStyle),
                  ))
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
