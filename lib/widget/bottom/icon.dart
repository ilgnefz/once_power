import 'package:flutter_anchored_overlay/flutter_anchored_overlay.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/widget/base/icon.dart';

class const BottomClickIcon({
  super.key,
  required final String tip,
  final IconData? icon,
  final String? svg,
  final bool selected = false,
  required final void Function() onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ClickIcon(
      tip: tip,
      placement: TooltipDirection.up,
      icon: icon,
      svg: svg,
      size: 24,
      iconSize: 17,
      color: selected ? theme.colorScheme.primary : theme.iconTheme.color,
      onPressed: onPressed,
    );
  }
}
