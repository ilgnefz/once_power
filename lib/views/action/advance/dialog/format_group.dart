import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/widgets/action/dialog_option.dart';
import 'package:once_power/widgets/base/easy_radio.dart';
import 'package:once_power/widgets/common/dropdown_text.dart';

class FormatGroup extends StatelessWidget {
  const FormatGroup({
    super.key,
    required this.mode,
    required this.onChanged,
    required this.position,
    required this.onPositionChanged,
  });

  final ReplaceMode mode;
  final void Function(ReplaceMode) onChanged;
  final FillPosition position;
  final void Function(FillPosition) onPositionChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return DialogOption(
      title: '${tr(AppL10n.advanceReplaceMode)}: ',
      padding: EdgeInsets.only(top: 4.0),
      alignment: WrapAlignment.spaceBetween,
      children: ReplaceMode.values.map((e) {
        return EasyRadio(
          label: e.label,
          value: e,
          groupValue: mode,
          trailing: e.isFormat
              ? TextDropdown(
                  items: FillPosition.values
                      .map(
                        (item) => DropdownMenuItem(
                          key: ValueKey(item),
                          value: item,
                          child: Text(
                            item.label,
                            style: theme.dropdownMenuTheme.textStyle,
                          ),
                        ),
                      )
                      .toList(),
                  width: 98,
                  color: theme.popupMenuTheme.surfaceTintColor,
                  value: position,
                  onChanged: (value) => onPositionChanged(value!),
                )
              : null,
          onChanged: (value) => onChanged(value!),
        );
      }).toList(),
    );
  }
}
