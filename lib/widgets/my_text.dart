import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText(
    this.data, {
    super.key,
    this.style,
    this.fontSize,
    this.color,
    this.maxLines,
    this.fontWeight,
  });

  final String data;
  final TextStyle? style;
  final double? fontSize;
  final Color? color;
  final int? maxLines;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    TextStyle myStyle = TextStyle(
      fontSize: fontSize ?? 14,
      color: color,
      fontWeight: fontWeight,
    ).useSystemChineseFont();

    return Text(
      data,
      style: style ?? myStyle,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
