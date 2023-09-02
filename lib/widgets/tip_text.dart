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
          fontSize: 12,
          color: Theme.of(context).primaryColor.withOpacity(.8),
        ),
        children: [
          TextSpan(
            text: content,
            style: const TextStyle(color: Color(0xFF666666)),
          )
        ],
      ),
    );
  }
}
