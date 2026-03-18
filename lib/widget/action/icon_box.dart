import 'package:flutter/material.dart';
import 'package:once_power/config/theme/icon_box.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:once_power/widget/common/tooltip.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class IconBox extends StatelessWidget {
  const IconBox({
    super.key,
    required this.tip,
    required this.icon,
    required this.checked,
    required this.onPressed,
  });

  final String tip;
  final String icon;
  final bool checked;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Color? background = checked
        ? theme.primaryColor
        : theme.extension<IconBoxTheme>()?.backgroundColor;
    Color? iconColor = checked
        ? Colors.white
        : theme.extension<IconBoxTheme>()?.iconColor;
    final BorderRadius borderRadius = .circular(AppNum.radius);

    return EasyTooltip(
      tip: tip,
      placement: Placement.right,
      child: Material(
        color: background,
        borderRadius: borderRadius,
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: Container(
            height: AppNum.widgetHeight,
            width: AppNum.widgetHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: borderRadius),
            child: BaseIcon(svg: icon, color: iconColor, size: 20),
          ),
        ),
      ),
    );
  }
}
