import 'package:flutter_anchored_overlay/flutter_anchored_overlay.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/widget/base/icon.dart';

class BottomClickIcon extends StatelessWidget {
  const BottomClickIcon({
    super.key,
    required this.tip,
    this.icon,
    this.svg,
    this.selected = false,
    required this.onPressed,
  });

  final String tip;
  final IconData? icon;
  final String? svg;
  final bool selected;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ClickIcon(
      tip: tip,
      placement: TooltipDirection.up,
      icon: icon,
      svg: svg,
      size: 24,
      iconSize: 17,
      color: selected ? Theme.of(context).colorScheme.primary : Colors.grey,
      onPressed: onPressed,
    );
  }
}
