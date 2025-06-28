import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/widgets/base/easy_tooltip.dart';
import 'package:once_power/widgets/base/svg_icon.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

class IconBox extends StatelessWidget {
  const IconBox(
    this.icon, {
    super.key,
    required this.tip,
    this.placement = Placement.right,
    this.iconSize = 20,
    required this.selected,
    required this.onTap,
  });

  final String tip;
  final Placement placement;
  final String icon;
  final double iconSize;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const borderRadius = BorderRadius.all(Radius.circular(8));
    return EasyTooltip(
      tip: tip,
      placement: placement,
      textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666))
          .useSystemChineseFont(),
      child: Material(
        borderRadius: borderRadius,
        child: Ink(
          height: AppNum.inputH,
          width: AppNum.inputH,
          decoration: BoxDecoration(
            color: selected ? theme.primaryColor : theme.dividerColor,
            borderRadius: borderRadius,
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius,
            child: Align(
              child: SvgIcon(
                icon,
                color: selected
                    ? Colors.white
                    : theme.inputDecorationTheme.iconColor,
                size: iconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
