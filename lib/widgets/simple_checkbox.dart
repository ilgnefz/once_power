import 'package:flutter/material.dart';
import 'package:once_power/widgets/my_text.dart';

class SimpleCheckbox extends StatelessWidget {
  const SimpleCheckbox({
    super.key,
    required this.title,
    required this.checked,
    required this.onChange,
    this.action,
    this.color,
  });

  final String title;
  final bool checked;
  final void Function(bool?)? onChange;
  final Widget? action;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: checked, onChanged: onChange),
        MyText(title, color: color),
        if (action != null) action!
      ],
    );
  }
}
