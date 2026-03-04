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
    this.obscureText = false,
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
  final EdgeInsets? padding;
  final bool obscureText;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: AppNum.widgetHeight,
      padding: padding,
      decoration: BoxDecoration(
        color: theme.inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .1), blurRadius: 2),
        ],
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          if (leading != null) leading!,
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              obscureText: obscureText,
              cursorHeight: 20,
              cursorRadius: Radius.circular(4),
              textAlign: textAlign,
              inputFormatters: inputFormatters,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: theme.inputDecorationTheme.hintStyle,
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
