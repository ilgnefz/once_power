import 'package:flutter/material.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key, required this.style});

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text('中文', style: style);
  }
}
