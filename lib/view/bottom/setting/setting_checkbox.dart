import 'package:flutter/material.dart';
import 'package:once_power/widget/common/one_line_text.dart';

class SettingCheckbox extends StatelessWidget {
  const SettingCheckbox({
    super.key,
    required this.label,
    required this.checked,
    this.disabled = false,
    required this.onChanged,
  });

  final String label;
  final bool checked;
  final bool disabled;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      mouseCursor: disabled ? null : SystemMouseCursors.click,
      onTap: disabled ? null : () => onChanged(!checked),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Row(
        children: [
          OneLineText(label),
          Checkbox(
            value: checked,
            mouseCursor: disabled ? null : SystemMouseCursors.click,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: theme.checkboxTheme.side,
            checkColor: Colors.white,
            fillColor: disabled
                ? WidgetStateProperty.all(theme.disabledColor)
                : theme.checkboxTheme.fillColor,
            onChanged: disabled ? null : (value) => onChanged(value!),
          ),
        ],
      ),
    );
  }
}
