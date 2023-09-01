import 'package:flutter/material.dart';

class EasyCheckbox extends StatelessWidget {
  const EasyCheckbox(
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
