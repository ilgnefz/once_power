import 'package:flutter/material.dart';
import 'package:once_power/widgets/base/easy_icon.dart';

class ClickIcon extends StatelessWidget {
  const ClickIcon({
    super.key,
    this.icon,
    this.svg,
    this.size = 28,
    this.iconSize = 20,
    this.color,
    this.shadows,
    this.onPressed,
    this.onSecondaryTap,
    this.onLongPress,
  });

  final double? size;
  final IconData? icon;
  final String? svg;
  final double? iconSize;
  final Color? color;
  final List<Shadow>? shadows;
  final void Function()? onPressed;
  final void Function()? onSecondaryTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
          child: InkWell(
            onTap: onPressed,
            onSecondaryTap: onSecondaryTap,
            onLongPress: onLongPress,
            borderRadius: BorderRadius.circular(24),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            // hoverColor: Colors.transparent,
            child: Container(
              height: size,
              width: size,
              alignment: Alignment.center,
              child: EasyIcon(
                iconSize: iconSize,
                icon: icon,
                svg: svg,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
