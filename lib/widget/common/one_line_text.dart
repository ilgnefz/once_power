import 'package:flutter/material.dart';
import 'package:once_power/widget/base/text.dart';

class OneLineText extends StatelessWidget {
  const OneLineText(this.data, {super.key, this.color, this.fontSize});

  final String data;
  final Color? color;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: BaseText(
        data,
        color: color,
        fontSize: fontSize,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
