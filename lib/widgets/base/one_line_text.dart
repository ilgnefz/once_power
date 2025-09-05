import 'package:flutter/material.dart';

class OneLineText extends StatelessWidget {
  const OneLineText(
    this.data, {
    super.key,
    this.flex = 1,
    this.padding,
    this.style,
    this.fontSize,
    this.color,
  });

  final int flex;
  final String data;
  final EdgeInsets? padding;
  final TextStyle? style;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          data,
          style: style ?? TextStyle(fontSize: fontSize, color: color),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
