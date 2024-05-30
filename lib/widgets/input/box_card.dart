import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/colors.dart';
import 'package:once_power/widgets/custom_tooltip.dart';
import 'package:once_power/widgets/svg_icon.dart';

class BoxCard extends StatelessWidget {
  const BoxCard(
    this.icon, {
    super.key,
    required this.message,
    required this.selected,
    required this.onTap,
  });

  final String message;
  final String icon;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CustomTooltip(
      message: message,
      textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666))
          .useSystemChineseFont(),
      child: Ink(
        height: 32,
        width: 32,
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
            child: SvgIcon(icon, color: selected ? Colors.white : null),
          ),
        ),
      ),
    );
  }
}
