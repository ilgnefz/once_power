import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/widgets/base/easy_tooltip.dart';
import 'package:once_power/widgets/base/svg_icon.dart';

class IconBox extends StatelessWidget {
  const IconBox(
    this.icon, {
    super.key,
    required this.tip,
    this.iconSize = 20,
    required this.selected,
    required this.onTap,
  });

  final String tip;
  final String icon;
  final double iconSize;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return EasyTooltip(
      tip: tip,
      textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666))
          .useSystemChineseFont(),
      child: Ink(
        height: AppNum.inputH,
        width: AppNum.inputH,
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).primaryColor
              : AppColors.unselectBoxIcon,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Align(
            child: SvgIcon(
              icon,
              color: selected ? Colors.white : null,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
