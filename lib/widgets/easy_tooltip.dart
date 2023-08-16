import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

class EasyTooltip extends StatelessWidget {
  const EasyTooltip({super.key, required this.message, required this.child});

  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      // preferBelow: false,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(.2))
        ],
      ),
      waitDuration: const Duration(seconds: 1),
      textStyle: const TextStyle(color: Color(0xFF666666), fontSize: 12)
          .useSystemChineseFont(),
      child: child,
    );
  }
}
