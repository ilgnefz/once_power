import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:once_power/widgets/common/custom_tooltip.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class TooltipIcon extends StatelessWidget {
  const TooltipIcon({
    super.key,
    required this.message,
    required this.icon,
    this.selected = false,
    required this.onTap,
  });

  final String message;
  final String icon;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return EasyTooltip(
      message: message,
      textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666))
          .useSystemChineseFont(),
      placement: Placement.top,
      child: ClickIcon(
        size: AppNum.iconMediumS + 8,
        iconSize: AppNum.iconMediumS,
        svg: icon,
        color: selected ? Theme.of(context).primaryColor : Colors.grey,
        onTap: onTap,
      ),
    );
  }
}
