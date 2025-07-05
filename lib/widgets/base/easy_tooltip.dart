import 'dart:io';

import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

class EasyTooltip extends StatelessWidget {
  const EasyTooltip({
    super.key,
    this.tip,
    this.richMessage,
    this.textStyle,
    this.placement = Placement.right,
    this.waitDuration = const Duration(milliseconds: 800),
    required this.child,
  });

  final String? tip;
  final InlineSpan? richMessage;
  final TextStyle? textStyle;
  final Placement placement;
  final Duration? waitDuration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TolyTooltip(
      message: tip,
      textStyle: textStyle,
      richMessage: richMessage,
      decorationConfig: DecorationConfig(
        style: PaintingStyle.stroke,
        textColor: Theme.of(context).textTheme.labelMedium?.color,
        backgroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      gap: AppNum.largeG,
      placement: placement,
      waitDuration: waitDuration,
      child: child,
    );
  }
}

TextSpan richTextTooltip(BuildContext context, String label, String desc,
    [bool isLast = false]) {
  desc = Characters(desc).join('\u{200B}');
  final theme = Theme.of(context);
  return TextSpan(
    text: '$label: ',
    style: TextStyle(
      fontSize: 13,
      color: theme.primaryColor.withValues(alpha: .8),
      fontFamily: Platform.isWindows ? 'Microsoft YaHei' : null,
    ).useSystemChineseFont(),
    children: [
      TextSpan(
        text: isLast ? desc : '$desc\n',
        style: TextStyle(
          fontSize: 13,
          color: theme.colorScheme.surfaceContainerLow,
          fontFamily: Platform.isWindows ? 'Microsoft YaHei' : null,
        ).useSystemChineseFont(),
      ),
    ],
  );
}
