import 'package:flutter/material.dart';

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
