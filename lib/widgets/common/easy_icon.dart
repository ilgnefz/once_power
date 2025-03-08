import 'package:flutter/material.dart';
import 'package:once_power/widgets/base/svg_icon.dart';

class EasyIcon extends StatelessWidget {
  const EasyIcon({
    super.key,
    this.icon,
    this.svg,
    this.iconSize,
    this.color,
  }) : assert(icon != null || svg != null);

  final IconData? icon;
  final String? svg;
  final double? iconSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? FittedBox(child: Icon(icon, size: iconSize, color: color))
        : SvgIcon(svg!, size: iconSize, color: color);
  }
}
