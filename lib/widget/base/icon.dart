import 'package:flutter_anchored_overlay/flutter_anchored_overlay.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';

import 'tooltip.dart';

class const BaseIcon({
  super.key,
  final IconData? icon,
  final String? svg,
  final double? size,
  final Color? color,
}) extends StatelessWidget {
  this : assert(icon != null || svg != null, 'icon or svg must be provided');

  @override
  Widget build(BuildContext context) {
    Color iconColor = color ?? Theme.of(context).iconTheme.color!;
    return icon != null
        ? Icon(icon, size: size, color: color)
        : SvgPicture.asset(
            svg!,
            width: size ?? 20.0,
            height: size ?? 20.0,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          );
  }
}

class const ClickIcon({
  super.key,
  final String? tip,
  final TooltipDirection placement = .right,
  final IconData? icon,
  final String? svg,
  final double? size,
  final double? iconSize,
  final Color? color,
  final void Function()? onPressed,
  final void Function()? onSecondaryTap,
  final void Function()? onLongPress,
}) extends StatelessWidget {
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
