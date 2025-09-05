import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class BaseInput extends StatelessWidget {
  const BaseInput({
    super.key,
    this.padding,
    this.leading,
    this.focusNode,
    this.onKeyEvent,
    this.controller,
    this.enable,
    this.hintText,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.onChanged,
    this.maxLines = 1,
    this.show = false,
    this.onClear,
    this.trailing,
  });

  final EdgeInsets? padding;
  final Widget? leading;
  final FocusNode? focusNode;
  final void Function(KeyEvent)? onKeyEvent;
  final TextEditingController? controller;
  final bool? enable;
  final String? hintText;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final int maxLines;
  final bool show;
  final void Function()? onClear;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: AppNum.input,
      padding:
          padding ??
          const EdgeInsets.only(
            left: AppNum.paddingMedium,
            right: AppNum.spaceSmall,
          ),
      decoration: BoxDecoration(
        color: theme.inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .1), blurRadius: 2),
        ],
      ),
      child: Row(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) leading!,
          Expanded(
            child: KeyboardListener(
              focusNode: focusNode ?? FocusNode(),
              onKeyEvent: onKeyEvent,
              child: TextField(
                controller: controller,
                enabled: enable,
                cursorHeight: 20,
                cursorRadius: Radius.circular(4),
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: theme.inputDecorationTheme.hintStyle,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
                textAlign: textAlign,
                inputFormatters: inputFormatters,
                onChanged: onChanged,
                maxLines: maxLines,
                contextMenuBuilder: (_, _) => SizedBox.shrink(),
              ),
            ),
          ),
          if (show)
            ClickIcon(
              icon: Icons.close_rounded,
              iconSize: 18,
              color: theme.iconTheme.color,
              onPressed: onClear,
            ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
