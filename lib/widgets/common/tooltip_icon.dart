import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/base/easy_tooltip.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class TooltipIcon extends StatelessWidget {
  const TooltipIcon({
    super.key,
    required this.tip,
    this.placement = Placement.top,
    this.svg,
    this.icon,
    this.size,
    this.iconSize,
    this.selected = false,
    this.color,
    required this.onPressed,
    this.onLongPress,
    this.onSecondaryTap,
  }) : assert(svg != null || icon != null);

  final String tip;
  final Placement placement;
  final String? svg;
  final IconData? icon;
  final double? size;
  final double? iconSize;
  final bool selected;
  final Color? color;
  final void Function() onPressed;
  final void Function()? onLongPress;
  final void Function()? onSecondaryTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return EasyTooltip(
      tip: tip,
      // textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666)),
      placement: placement,
      child: ClickIcon(
        size: size ?? AppNum.icon,
        iconSize: iconSize ?? AppNum.iconMedium,
        svg: svg,
        icon: icon,
        color: color ?? (selected ? theme.primaryColor : theme.iconTheme.color),
        onPressed: onPressed,
        onLongPress: onLongPress,
        onSecondaryTap: onSecondaryTap,
      ),
    );
  }
}
