import 'package:flutter/material.dart';

class EasyCheckbox extends StatelessWidget {
  const EasyCheckbox({
    super.key,
    this.mainAxisSize = MainAxisSize.max,
    this.height,
    this.width,
    this.label,
    this.child,
    required this.checked,
    this.fillColor,
    this.borderColor,
    this.style,
    this.sideWidth = 1,
    this.onChanged,
  }) : assert(label != null || child != null);

  final MainAxisSize mainAxisSize;
  final double? height;
  final double? width;
  final String? label;
  final Widget? child;
  final bool checked;
  final WidgetStateProperty<Color?>? fillColor;
  final Color? borderColor;
  final TextStyle? style;
  final double? sideWidth;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: mainAxisSize,
      children: [
        SizedBox(
          height: height,
          width: width,
          child: FittedBox(
            child: Checkbox(
              value: checked,
              onChanged: onChanged,
              fillColor: fillColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(
                  width: sideWidth!,
                  color: borderColor ?? theme.colorScheme.outline),
            ),
          ),
        ),
        if (label != null)
          Text(
            label!,
            style:
                style ?? TextStyle(color: theme.textTheme.labelMedium?.color),
          ),
        if (child != null) child!,
      ],
    );
  }
}
