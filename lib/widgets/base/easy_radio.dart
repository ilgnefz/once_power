import 'package:flutter/material.dart';

class EasyRadio<T> extends StatelessWidget {
  const EasyRadio({
    super.key,
    required this.label,
    this.mainAxisSize = MainAxisSize.min,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.space = 8,
    this.trailing,
  });

  final String label;
  final MainAxisSize mainAxisSize;
  final T value;
  final T groupValue;
  final void Function(T?) onChanged;
  final double space;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          side: Theme.of(context).checkboxTheme.side,
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
        if (trailing != null) ...[SizedBox(width: space), trailing!],
      ],
    );
  }
}
