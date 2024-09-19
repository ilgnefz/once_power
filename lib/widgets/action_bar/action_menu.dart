import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/widgets/common/box_card.dart';

class ActionMenu extends StatelessWidget {
  const ActionMenu({
    super.key,
    this.label,
    required this.slot,
    this.disable = false,
    this.controller,
    this.hintText = '',
    this.show = false,
    this.onChanged,
    required this.message,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String? label;
  final Widget slot;
  final bool disable;
  final TextEditingController? controller;
  final String hintText;
  final bool show;
  final void Function(String)? onChanged;
  final String message;
  final String icon;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (label != null) ...[Text('$label:'), const SizedBox(width: 8)],
        Expanded(child: slot),
        const SizedBox(width: AppNum.mediumG),
        BoxCard(icon, message: message, selected: selected, onTap: onTap),
      ],
    );
  }
}
