import 'package:flutter/material.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

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
      placement: Placement.top,
      icon: icon,
      svg: svg,
      size: 24,
      iconSize: 17,
      color: selected ? Theme.of(context).primaryColor : Colors.grey,
      onPressed: onPressed,
    );
  }
}
