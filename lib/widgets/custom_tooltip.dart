import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

class CustomTooltip extends StatelessWidget {
  const CustomTooltip({
    super.key,
    this.message,
    this.richMessage,
    this.textStyle,
    this.placement = Placement.right,
    this.waitDuration = const Duration(milliseconds: 800),
    required this.child,
  });

  final String? message;
  final InlineSpan? richMessage;
  final TextStyle? textStyle;
  final Placement placement;
  final Duration? waitDuration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TolyTooltip(
      message: message,
      textStyle: textStyle,
      richMessage: richMessage,
      decorationConfig: const DecorationConfig(
        style: PaintingStyle.stroke,
        textColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      gap: 12,
      placement: placement,
      waitDuration: waitDuration,
      child: child,
    );
  }
}

TextSpan richTextTooltip(BuildContext context, String label, String desc,
    [bool isLast = false]) {
  desc = Characters(desc).join('\u{200B}');
  return TextSpan(
    text: '$label: ',
    style: TextStyle(
      fontSize: 13,
      color: Theme.of(context).primaryColor.withOpacity(.8),
    ).useSystemChineseFont(),
    children: [
      TextSpan(
        text: isLast ? desc : '$desc\n',
        style: const TextStyle(fontSize: 13, color: Color(0xFF666666))
            .useSystemChineseFont(),
      ),
    ],
  );
}
