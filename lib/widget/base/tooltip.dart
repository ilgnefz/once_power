import 'package:flutter_anchored_overlay/flutter_anchored_overlay.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/theme/theme.dart';
import 'package:once_power/constant/color.dart';
import 'package:once_power/constant/number.dart';

class const EasyTooltip({
  super.key,
  final String? tip,
  final Widget? richMessage,
  final TextStyle? textStyle,
  final TooltipDirection placement = TooltipDirection.right,
  final Duration waitDuration = const Duration(milliseconds: 800),
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    return SmartTooltip(
      message: tip,
      textStyle:
          textStyle ??
          theme.textTheme.bodySmall?.copyWith(
            color: isDark ? AppColors.tooltipTextDark : AppColors.tooltipText,
          ),
      backgroundColor: isDark ? AppColors.tooltipDark : AppColors.tooltip,
      richMessage: richMessage,
      gap: AppNumber.spaceSmall,
      placement: placement,
      waitDuration: waitDuration,
      contentPadding: .symmetric(horizontal: 8, vertical: 6),
      child: child,
    );
  }
}

TextSpan richTextTooltip(
  BuildContext context,
  String label,
  String desc, [
  bool isLast = false,
]) {
  desc = Characters(desc).join('\u{200B}');
  final theme = Theme.of(context);
  return TextSpan(
    text: '$label: ',
    style: TextStyle(
      fontSize: 13,
      color: theme.colorScheme.primary.withValues(alpha: .8),
      fontFamily: ThemeConfig.font,
    ),
    children: [
      TextSpan(
        text: isLast ? desc : '$desc\n',
        style: TextStyle(
          fontSize: 13,
          color: theme.textTheme.labelMedium?.color,
          fontFamily: ThemeConfig.font,
        ),
      ),
    ],
  );
}
