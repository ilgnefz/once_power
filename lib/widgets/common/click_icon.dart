import 'package:flutter/material.dart';

import 'svg_icon.dart';

class ClickIcon extends StatelessWidget {
  const ClickIcon({
    super.key,
    this.message,
    this.icon,
    this.svg,
    this.size = 24,
    this.iconSize = 20,
    this.color,
    this.onTap,
  });

  final String? message;
  final double? size;
  final IconData? icon;
  final String? svg;
  final double? iconSize;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: size,
            width: size,
            alignment: Alignment.center,
            child: icon != null
                ? FittedBox(child: Icon(icon, size: iconSize, color: color))
                : SvgIcon(svg!, size: iconSize, color: color),
          ),
        ),
      ),
    );
  }
}
