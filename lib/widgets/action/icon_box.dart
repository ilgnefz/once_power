import 'package:flutter/material.dart';
import 'package:once_power/config/theme/custom.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/base/easy_icon.dart';
import 'package:once_power/widgets/base/easy_tooltip.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class IconBox extends StatelessWidget {
  const IconBox({
    super.key,
    required this.tip,
    required this.icon,
    required this.checked,
    this.onPressed,
  });

  final String tip;
  final String icon;
  final bool checked;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Color? background = checked
        ? theme.primaryColor
        : theme.extension<IconBoxTheme>()?.backgroundColor;
    Color? iconColor = checked
        ? Colors.white
        : theme.extension<IconBoxTheme>()?.iconColor;
    final BorderRadius borderRadius = BorderRadius.circular(8);
    return EasyTooltip(
      tip: tip,
      placement: Placement.right,
      child: Material(
        color: background,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onPressed,
          child: Container(
            height: AppNum.input,
            width: AppNum.input,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: borderRadius),
            child: EasyIcon(svg: icon, color: iconColor, iconSize: 20),
          ),
        ),
      ),
    );
  }
}
