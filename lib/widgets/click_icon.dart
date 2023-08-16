import 'package:flutter/material.dart';

class ClickIcon extends StatelessWidget {
  const ClickIcon({
    super.key,
    this.size = 24,
    required this.icon,
    this.iconSize = 18,
    this.color,
    this.onTap,
  });

  final double? size;
  final IconData icon;
  final double? iconSize;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: size,
            width: size,
            alignment: Alignment.center,
            child: Icon(icon, size: iconSize, color: color),
          ),
        ),
      ),
    );
  }
}
