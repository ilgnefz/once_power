import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';

class EasyChip extends StatelessWidget {
  const EasyChip({
    super.key,
    required this.label,
    required this.selected,
    this.fontSize = 14,
    required this.onTap,
    this.enable = true,
  });

  final String label;
  final bool selected;
  final double fontSize;
  final void Function()? onTap;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const borderRadius = BorderRadius.all(Radius.circular(8));
    Color bgColor = enable
        ? (selected
            ? theme.primaryColor
            : theme.primaryColor.withValues(alpha: .2))
        : theme.disabledColor;
    Color textColor =
        enable ? (selected ? Colors.white : theme.primaryColor) : Colors.grey;

    return Material(
      borderRadius: borderRadius,
      child: Ink(
        decoration: BoxDecoration(color: bgColor, borderRadius: borderRadius),
        child: InkWell(
          onTap: enable ? onTap : null,
          borderRadius: borderRadius,
          child: Container(
            height: AppNum.inputH,
            padding: const EdgeInsets.symmetric(horizontal: AppNum.defaultP),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(fontSize: fontSize, color: textColor)
                  .useSystemChineseFont(),
            ),
          ),
        ),
      ),
    );
  }
}
