import 'package:flutter/material.dart';
import 'package:once_power/widgets/base/svg_icon.dart';

class EasyIcon extends StatelessWidget {
  const EasyIcon({
    super.key,
    this.icon,
    this.svg,
    this.iconSize,
    this.color,
    this.shadows,
  }) : assert(icon != null || svg != null);

  final IconData? icon;
  final String? svg;
  final double? iconSize;
  final Color? color;
  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? FittedBox(
            child: Icon(icon, size: iconSize, color: color, shadows: shadows),
          )
        : SvgIcon(svg!, size: iconSize, color: color);
  }
}
