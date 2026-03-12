import 'package:flutter/material.dart';

class EasyRadio<T> extends StatelessWidget {
  const EasyRadio({
    super.key,
    required this.label,
    this.mainAxisSize = MainAxisSize.min,
    required this.value,
    this.space = 8,
    this.trailing,
  });

  final String label;
  final MainAxisSize mainAxisSize;
  final T value;
  final double space;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio(
          mouseCursor: SystemMouseCursors.click,
          value: value,
          side: theme.checkboxTheme.side,
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(label, style: theme.textTheme.bodyMedium?.copyWith(height: 1.5)),
        if (trailing != null) ...[SizedBox(width: space), trailing!],
      ],
    );
  }
}
