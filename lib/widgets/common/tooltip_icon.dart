import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/widgets/base/easy_tooltip.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class TooltipIcon extends StatelessWidget {
  const TooltipIcon({
    super.key,
    required this.tip,
    this.placement = Placement.top,
    this.svg,
    this.icon,
    this.size,
    this.iconSize,
    this.selected = false,
    this.color,
    required this.onTap,
  }) : assert(svg != null || icon != null);

  final String tip;
  final Placement placement;
  final String? svg;
  final IconData? icon;
  final double? size;
  final double? iconSize;
  final bool selected;
  final Color? color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return EasyTooltip(
      tip: tip,
      textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666))
          .useSystemChineseFont(),
      placement: placement,
      child: ClickIcon(
        size: size ?? AppNum.iconMediumS + 8,
        iconSize: AppNum.iconMediumS,
        svg: svg,
        icon: icon,
        color: color ?? (selected ? theme.primaryColor : theme.iconTheme.color),
        onTap: onTap,
      ),
    );
  }
}
