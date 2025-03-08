import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/action_bar/icon_box.dart';

class OperateItem extends StatelessWidget {
  const OperateItem({
    super.key,
    this.label,
    required this.icon,
    required this.tip,
    required this.selected,
    required this.onToggle,
    required this.child,
  });

  final String? label;
  final String icon;
  final String tip;
  final bool selected;
  final void Function() onToggle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppNum.defaultP),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppNum.mediumG,
        children: [
          if (label != null) Text('$label:'),
          Expanded(child: child),
          IconBox(icon, tip: tip, selected: selected, onTap: onToggle),
        ],
      ),
    );
  }
}
