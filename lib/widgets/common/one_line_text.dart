import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

class OneLineText extends StatelessWidget {
  const OneLineText(this.data,
      {super.key, this.padding, this.style, this.fontSize, this.color});

  final String data;
  final EdgeInsets? padding;
  final TextStyle? style;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          data,
          style: style ??
              TextStyle(fontSize: fontSize, color: color)
                  .useSystemChineseFont(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
