import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/action/icon_box.dart';

class ActionItem extends StatelessWidget {
  const ActionItem({
    super.key,
    this.label,
    required this.icon,
    required this.tip,
    required this.checked,
    required this.onPressed,
    required this.child,
  });

  final String? label;
  final Widget child;
  final String icon;
  final String tip;
  final bool checked;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: Row(
        spacing: AppNum.spaceMedium,
        children: [
          if (label != null) Text('${label!}:'),
          Expanded(child: child),
          IconBox(tip: tip, icon: icon, checked: checked, onPressed: onPressed),
        ],
      ),
    );
  }
}
