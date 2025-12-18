import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class DirectiveItemBtn extends ConsumerWidget {
  const DirectiveItemBtn({super.key, required this.icon, this.onTap});

  final IconData icon;
  final void Function(WidgetRef)? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double size = 20;
    final double iconSize = 16;
    final Color iconColor = Colors.grey;
    return ClickIcon(
      size: size,
      iconSize: iconSize,
      icon: icon,
      color: iconColor,
      onPressed: () => onTap?.call(ref),
    );
  }
}
