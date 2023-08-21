import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

class EasyTooltip extends StatelessWidget {
  const EasyTooltip({
    super.key,
    this.message,
    this.richMessage,
    this.padding,
    this.margin,
    required this.child,
  });

  final String? message;
  final InlineSpan? richMessage;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      // preferBelow: false,
      richMessage: richMessage,
      verticalOffset: 16,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(.2))
        ],
      ),
      waitDuration: const Duration(seconds: 1),
      textStyle: richMessage == null
          ? const TextStyle(color: Color(0xFF666666), fontSize: 12)
              .useSystemChineseFont()
          : null,
      child: child,
    );
  }
}
