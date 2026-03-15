import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/const/num.dart';

class BaseInput extends StatelessWidget {
  const BaseInput({
    super.key,
    this.focusNode,
    this.controller,
    this.hintText = '',
    this.leading,
    this.action,
    this.clearButton,
    this.padding,
    this.margin,
    this.autofocus = false,
    this.obscureText = false,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.onChange,
  });

  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String hintText;
  final Widget? leading;
  final Widget? action;
  final Widget? clearButton;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool autofocus;
  final bool obscureText;
  final bool enabled;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: AppNum.widgetHeight,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: theme.inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.inputDecorationTheme.outlineBorder!.color,
          width: 1,
        ),
        // boxShadow: [
        //   BoxShadow(color: Colors.black.withValues(alpha: .1), blurRadius: 2),
        // ],
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          if (leading != null) leading!,
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              autofocus: autofocus,
              obscureText: obscureText,
              enabled: enabled,
              cursorHeight: 20,
              cursorRadius: Radius.circular(4),
              textAlign: textAlign,
              inputFormatters: inputFormatters,
              style: theme.textTheme.bodyMedium?.copyWith(
                decoration: enabled
                    ? null
                    : TextDecoration.combine([TextDecoration.lineThrough]),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
                  decoration: TextDecoration.combine([TextDecoration.none]),
                ),
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: onChange,
              // onTap: () => controller?.selection = TextSelection(
              //   baseOffset: 0,
              //   extentOffset: controller!.text.length,
              // ),
            ),
          ),
          ?clearButton,
          ?action,
        ],
      ),
    );
  }
}
