import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';

class const BaseInput({
  super.key,
  required final String hintText,
  final bool obscureText = false,
  final bool enabled = true,
  final List<TextInputFormatter>? inputFormatters,
  final TextStyle? style,
  final TextAlign textAlign = .left,
  final EdgeInsetsGeometry? contentPadding,
  required final TextEditingController controller,
  required final void Function(String value)? onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextField(
      controller: controller,
      onChanged: onChanged,
      cursorHeight: 16,
      obscureText: obscureText,
      enabled: enabled,
      inputFormatters: inputFormatters,
      cursorRadius: .circular(AppNumber.radiusSmall),
      style: style ?? theme.textTheme.bodyMedium,
      textAlign: textAlign,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.inputDecorationTheme.hintStyle,
        border: InputBorder.none,
        isCollapsed: true,
        contentPadding: contentPadding,
      ),
    );
  }
}
