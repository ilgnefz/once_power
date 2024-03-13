import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(
    this.label, {
    super.key,
    required this.checked,
    this.style,
    this.onChanged,
  });

  final String label;
  final bool checked;
  final TextStyle? style;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: checked, onChanged: onChanged),
        Text(label, style: style),
      ],
    );
  }
}
