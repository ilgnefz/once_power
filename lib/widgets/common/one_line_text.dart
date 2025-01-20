import 'package:flutter/material.dart';

class OneLineText extends StatelessWidget {
  const OneLineText(this.data, {super.key, this.padding, this.style});

  final String data;
  final EdgeInsets? padding;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          data,
          style: style,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
