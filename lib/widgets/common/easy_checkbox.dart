import 'package:flutter/material.dart';

class EasyCheckbox extends StatelessWidget {
  const EasyCheckbox(
    this.label, {
    super.key,
    this.mainAxisSize = MainAxisSize.max,
    this.height,
    this.width,
    required this.checked,
    this.fillColor,
    this.borderColor = Colors.black,
    this.style,
    this.onChanged,
  });

  final MainAxisSize mainAxisSize;
  final double? height;
  final double? width;
  final String label;
  final bool checked;
  final WidgetStateProperty<Color?>? fillColor;
  final Color borderColor;
  final TextStyle? style;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(width: 1, color: borderColor),
            ),
          ),
        ),
        Text(label, style: style),
      ],
    );
  }
}
