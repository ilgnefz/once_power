import 'package:flutter/material.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class DirectiveItemBtn extends StatelessWidget {
  const DirectiveItemBtn({super.key, required this.icon, this.onTap});

  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final double size = 20;
    final double iconSize = 16;
    final Color iconColor = Colors.grey;
    return ClickIcon(
      size: size,
      iconSize: iconSize,
      icon: icon,
      color: iconColor,
      onTap: onTap,
    );
  }
}
