import 'package:flutter/material.dart';

class EasyCheckbox extends StatelessWidget {
  const EasyCheckbox({
    super.key,
    required this.checked,
    required this.onChanged,
    this.label,
    this.space = 0,
    this.child,
  });

  final bool? checked;
  final Function(bool?)? onChanged;
  final String? label;
  final double space;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    Widget checkbox = Checkbox(
      value: checked,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: theme.checkboxTheme.side,
      checkColor: Colors.white,
      fillColor: theme.checkboxTheme.fillColor,
      mouseCursor: SystemMouseCursors.click,
      onChanged: onChanged,
    );

    Widget row = Row(
      mainAxisSize: .min,
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      children: [
        checkbox,
        if (label != null)
          Text(
            label!,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        if (space > 0) SizedBox(width: space),
        ?child,
      ],
    );

    return RepaintBoundary(
      child: label == null && child == null ? checkbox : row,
    );
  }
}
