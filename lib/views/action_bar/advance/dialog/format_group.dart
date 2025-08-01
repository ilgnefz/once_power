import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/widgets/action_bar/dialog_option.dart';
import 'package:once_power/widgets/action_bar/easy_radio.dart';
import 'package:once_power/widgets/common/easy_text_dropdown.dart';

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
    final theme = Theme.of(context);
    return DialogOption(
      title: '${S.of(context).replaceMode}: ',
      padding: EdgeInsets.zero,
      alignment: WrapAlignment.spaceBetween,
      children: ReplaceMode.values.map((e) {
        return EasyRadio(
          label: e.label,
          value: e,
          groupValue: mode,
          trailing: e.isFormat
              ? EasyTextDropdown(
                  items: FillPosition.values
                      .map((item) => DropdownMenuItem(
                            key: ValueKey(item),
                            value: item,
                            child: Text(
                              item.label,
                              style: TextStyle(
                                color: theme.textTheme.labelMedium?.color,
                              ),
                            ),
                          ))
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
