import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/provider/theme.dart';
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
    this.obscureText = false,
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
  final bool obscureText;
  final bool show;
  final void Function()? onClear;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Consumer(
      builder: (_, ref, child) {
        return Container(
          height: AppNum.input,
          padding: padding ??
              const EdgeInsets.only(
                left: AppNum.paddingMedium,
                right: AppNum.spaceSmall,
              ),
          decoration: BoxDecoration(
            color: theme.inputDecorationTheme.fillColor?.withValues(
              alpha: ref.watch(translucentInputProvider) ? .5 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .1),
                blurRadius: 2,
              ),
            ],
          ),
          child: child!,
        );
      },
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
                obscureText: obscureText,
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
                contextMenuBuilder: (_, __) => SizedBox.shrink(),
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
