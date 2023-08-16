import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(this.icon, {super.key, this.color});

  final String icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      width: 20,
      height: 20,
      colorFilter:
          color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
      // semanticsLabel: 'Acme Logo',
    );
  }
}
