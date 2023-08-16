import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/widgets/action_bar/box_card.dart';
import 'package:once_power/widgets/base_input.dart';

class CommonInputMenu extends StatelessWidget {
  const CommonInputMenu({
    super.key,
    this.label,
    this.slot,
    this.controller,
    this.hintText = '',
    this.show = false,
    required this.message,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String? label;
  final Widget? slot;
  final TextEditingController? controller;
  final String hintText;
  final bool show;
  final String message;
  final String icon;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (label != null) ...[Text('$label:'), const SizedBox(width: 4)],
        Expanded(
          child: slot ??
              BaseInput(
                controller: controller,
                hintText: hintText,
                show: show,
              ),
        ),
        const SizedBox(width: AppNum.gapH),
        BoxCard(icon, message: message, selected: selected, onTap: onTap),
      ],
    );
  }
}
