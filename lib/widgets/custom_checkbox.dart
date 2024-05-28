import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(
    this.label, {
    super.key,
    required this.checked,
    this.fillColor,
    this.borderColor = Colors.black,
    this.style,
    this.onChanged,
  });

  final String label;
  final bool checked;
  final WidgetStateProperty<Color?>? fillColor;
  final Color borderColor;
  final TextStyle? style;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: checked,
          onChanged: onChanged,
          fillColor: fillColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: BorderSide(width: 1, color: borderColor),
        ),
        Text(label, style: style),
      ],
    );
  }
}
