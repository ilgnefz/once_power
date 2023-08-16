import 'package:flutter/material.dart';
import 'package:once_power/widgets/my_text.dart';

class EasyRadio extends StatelessWidget {
  const EasyRadio(
    this.label, {
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int groupValue;
  final void Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: value, groupValue: groupValue, onChanged: onChanged),
        MyText(label),
      ],
    );
  }
}
