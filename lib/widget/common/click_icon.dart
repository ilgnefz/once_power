import 'package:flutter/material.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:once_power/widget/common/tooltip.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class ClickIcon extends StatelessWidget {
  const ClickIcon({
    super.key,
    this.tip,
    this.placement = Placement.right,
    this.icon,
    this.svg,
    this.size,
    this.iconSize,
    this.color,
    required this.onPressed,
    this.onSecondaryTap,
    this.onLongPress,
  });

  final String? tip;
  final Placement placement;
  final IconData? icon;
  final String? svg;
  final double? size;
  final double? iconSize;
  final Color? color;
  final void Function()? onPressed;
  final void Function()? onSecondaryTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    Widget child = Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
        child: InkWell(
          onTap: onPressed,
          onSecondaryTap: onSecondaryTap,
          onLongPress: onLongPress,
          mouseCursor: SystemMouseCursors.click,
          borderRadius: BorderRadius.circular(28),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            width: size ?? 28,
            height: size ?? 28,
            alignment: Alignment.center,
            child: BaseIcon(
              icon: icon,
              svg: svg,
              size: iconSize ?? (icon == null ? 18 : 20),
              color: color ?? Theme.of(context).iconTheme.color,
            ),
          ),
        ),
      ),
    );

    return tip == null
        ? child
        : EasyTooltip(tip: tip, placement: placement, child: child);
  }
}
