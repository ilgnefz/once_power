import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaseIcon extends StatelessWidget {
  const BaseIcon({super.key, this.icon, this.svg, this.size, this.color})
    : assert(icon != null || svg != null);

  final IconData? icon;
  final String? svg;
  final double? size;
  final Color? color;

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
