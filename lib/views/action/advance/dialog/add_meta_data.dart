import 'package:flutter/material.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/widgets/common/dropdown_text.dart';

class AddMetaData extends StatelessWidget {
  const AddMetaData({
    super.key,
    required this.metaData,
    required this.mateDataChange,
  });

  final FileMetaData metaData;
  final void Function(FileMetaData?) mateDataChange;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return TextDropdown(
      items: FileMetaData.values
          .map(
            (item) => DropdownMenuItem(
              key: ValueKey(item),
              value: item,
              child: Text(
                item.label,
                style: TextStyle(color: theme.textTheme.labelMedium?.color),
              ),
            ),
          )
          .toList(),
      width: 103,
      color: theme.popupMenuTheme.surfaceTintColor,
      value: metaData,
      onChanged: mateDataChange,
    );
  }
}
