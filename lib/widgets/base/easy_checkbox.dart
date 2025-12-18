import 'package:flutter/material.dart';

class EasyCheckbox extends StatelessWidget {
  const EasyCheckbox({
    super.key,
    required this.checked,
    required this.onChanged,
    this.label,
    this.child,
  });

  final bool? checked;
  final Function(bool?)? onChanged;
  final String? label;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return RepaintBoundary(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: checked,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            side: theme.checkboxTheme.side,
            checkColor: Colors.white,
            fillColor: theme.checkboxTheme.fillColor,
            onChanged: onChanged,
          ),
          if (label != null)
            Text(
              label!,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
