import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/action/icon_box.dart';

class ActionItem extends StatelessWidget {
  const ActionItem({
    super.key,
    this.label,
    required this.child,
    required this.tip,
    required this.icon,
    required this.checked,
    this.onPressed,
  });

  final String? label;
  final Widget child;
  final String tip;
  final String icon;
  final bool checked;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppNum.paddingMedium,
      children: [
        if (label != null)
          Text(label!, style: Theme.of(context).textTheme.bodyMedium),
        Expanded(child: child),
        IconBox(tip: tip, icon: icon, checked: checked, onPressed: onPressed),
      ],
    );
  }
}
