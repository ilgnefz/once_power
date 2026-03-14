import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  const BaseText(
    this.data, {
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.textAlign,
  });

  final String data;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
