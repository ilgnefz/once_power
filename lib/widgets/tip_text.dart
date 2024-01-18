import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

class TipText extends StatelessWidget {
  const TipText({super.key, required this.label, required this.content});

  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$label：',
        style: TextStyle(
          fontSize: 13,
          color: Theme.of(context).primaryColor.withOpacity(.8),
        ).useSystemChineseFont(),
        children: [
          TextSpan(
            text: content,
            style: const TextStyle(fontSize: 13, color: Color(0xFF666666))
                .useSystemChineseFont(),
          )
        ],
      ),
    );
  }
}
