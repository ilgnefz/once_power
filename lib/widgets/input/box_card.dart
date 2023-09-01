import 'package:flutter/material.dart';
import 'package:once_power/widgets/easy_tooltip.dart';
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
    return EasyTooltip(
      message: message,
      child: Ink(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).primaryColor
              : const Color(0xFFF5F5F5),
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
