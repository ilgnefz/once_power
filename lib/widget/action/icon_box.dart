import 'package:flutter_anchored_overlay/flutter_anchored_overlay.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/icon_box.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:once_power/widget/base/tooltip.dart';

class const IconBox({
  super.key,
  required final String tip,
  required final String icon,
  required final bool checked,
  required final void Function() onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IconBoxTheme iconBoxTheme = theme.extension<IconBoxTheme>()!;
    Color? background = checked
        ? theme.colorScheme.primary
        : iconBoxTheme.backgroundColor;
    Color? iconColor = checked ? Colors.white : iconBoxTheme.iconColor;
    final BorderRadius borderRadius = .circular(AppNumber.radius);

    return EasyTooltip(
      tip: tip,
      placement: TooltipDirection.right,
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return Material(
            color: background,
            borderRadius: borderRadius,
            elevation: 0,
            child: child,
          );
        },
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: Container(
            height: AppNumber.widgetHeight,
            width: AppNumber.widgetHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: borderRadius),
            child: BaseIcon(svg: icon, color: iconColor, size: 20),
          ),
        ),
      ),
    );
  }
}
