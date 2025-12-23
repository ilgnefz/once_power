import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/widgets/common/dialog_input.dart';
import 'package:once_power/widgets/common/dropdown_text.dart';

class AddMetaData extends StatelessWidget {
  const AddMetaData({
    super.key,
    required this.metaData,
    required this.addPrefix,
    required this.addSuffix,
    required this.mateDataChange,
    required this.addPrefixChange,
    required this.addSuffixChange,
  });

  final FileMetaData metaData;
  final String addPrefix;
  final String addSuffix;
  final void Function(FileMetaData?) mateDataChange;
  final void Function(String) addPrefixChange;
  final void Function(String) addSuffixChange;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      spacing: AppNum.spaceSmall,
      children: [
        SizedBox(
          width: 80,
          child: DialogBaseInput(
            value: addPrefix,
            hintText: tr(AppL10n.advanceAddPrefix),
            onChanged: addPrefixChange,
          ),
        ),
        TextDropdown(
          items: FileMetaData.values
              .map(
                (item) => DropdownMenuItem(
                  key: ValueKey(item),
                  value: item,
                  child: Text(
                    item.label,
                    style: Theme.of(context).dropdownMenuTheme.textStyle,
                  ),
                ),
              )
              .toList(),
          width: 103,
          color: theme.popupMenuTheme.surfaceTintColor,
          value: metaData,
          onChanged: mateDataChange,
        ),
        SizedBox(
          width: 80,
          child: DialogBaseInput(
            value: addSuffix,
            hintText: tr(AppL10n.advanceAddSuffix),
            onChanged: addSuffixChange,
          ),
        ),
      ],
    );
  }
}
