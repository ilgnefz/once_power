import 'package:flutter/material.dart';
import 'package:once_power/widgets/common/easy_icon.dart';

class ClickIcon extends StatelessWidget {
  const ClickIcon({
    super.key,
    this.icon,
    this.svg,
    this.size = 24,
    this.iconSize = 20,
    this.color,
    this.shadows,
    this.onTap,
    this.onSecondaryTap,
  });

  final double? size;
  final IconData? icon;
  final String? svg;
  final double? iconSize;
  final Color? color;
  final List<Shadow>? shadows;
  final void Function()? onTap;
  final void Function()? onSecondaryTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
        child: InkWell(
          onTap: onTap,
          onSecondaryTap: onSecondaryTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: size,
            width: size,
            alignment: Alignment.center,
            child: EasyIcon(
              iconSize: iconSize,
              icon: icon,
              svg: svg,
              color: color,
              shadows: shadows,
            ),
          ),
        ),
      ),
    );
  }
}
