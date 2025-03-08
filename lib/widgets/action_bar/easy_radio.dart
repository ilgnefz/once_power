import 'package:flutter/material.dart';

class EasyRadio<T> extends StatelessWidget {
  const EasyRadio({
    super.key,
    required this.label,
    this.mainAxisSize = MainAxisSize.min,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.trailing,
  });

  final String label;
  final MainAxisSize mainAxisSize;
  final T value;
  final T groupValue;
  final void Function(T?) onChanged;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio(value: value, groupValue: groupValue, onChanged: onChanged),
        Text(label),
        if (trailing != null) trailing!,
      ],
    );
  }
}
