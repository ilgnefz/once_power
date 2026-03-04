import 'package:flutter/material.dart';
import 'package:once_power/config/theme/chip.dart';
import 'package:once_power/const/num.dart';

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
    final EasyChipTheme? theme = Theme.of(context).extension<EasyChipTheme>();
    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8));
    Color? bgColor = enable
        ? (selected ? theme?.selectBackgroundColor : theme?.backgroundColor)
        : theme?.disableBackgroundColor;
    TextStyle? style = enable
        ? (selected ? theme?.selectTextStyle : theme?.textStyle)
        : theme?.diableTextStyle;

    return Material(
      borderRadius: borderRadius,
      child: Ink(
        decoration: BoxDecoration(color: bgColor, borderRadius: borderRadius),
        child: InkWell(
          onTap: enable ? onTap : null,
          mouseCursor: SystemMouseCursors.click,
          borderRadius: borderRadius,
          child: Container(
            height: AppNum.widgetHeight,
            padding: const EdgeInsets.symmetric(horizontal: AppNum.padding),
            alignment: Alignment.center,
            child: Text(label, style: style),
          ),
        ),
      ),
    );
  }
}
