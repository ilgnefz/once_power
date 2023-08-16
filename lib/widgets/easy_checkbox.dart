import 'package:flutter/material.dart';

class EasyCheckbox extends StatelessWidget {
  const EasyCheckbox(
    this.label, {
    super.key,
    required this.checked,
    this.onChanged,
  });

  final String label;
  final bool checked;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Checkbox(value: true, onChanged: onChanged), Text(label)],
    );
  }
}
