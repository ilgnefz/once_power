import 'package:flutter/material.dart';
import 'package:once_power/config/theme/theme.dart';

class AdvanceRichText extends StatelessWidget {
  const AdvanceRichText({super.key, required this.text});

  final InlineSpan text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(text: text, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}

InlineSpan advanceTextSpan(
  String text, {
  required Color color,
  List<InlineSpan>? children,
}) {
  return TextSpan(
    text: text,
    children: children,
    style: TextStyle(fontSize: 14, fontFamily: defaultFont, color: color),
  );
}
