import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class BaseInput extends StatelessWidget {
  const BaseInput({
    super.key,
    this.controller,
    this.padding,
    this.enable = true,
    this.hintText = '',
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.leading,
    this.trailing,
    this.child,
    this.maxLines = 1,
    this.showClear = false,
    this.onKeyEvent,
    this.onChanged,
    this.onClear,
  });

  final TextEditingController? controller;
  final EdgeInsets? padding;
  final bool enable;
  final String hintText;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? leading;
  final Widget? trailing;
  final Widget? child;
  final int? maxLines;
  final bool showClear;
  final void Function(KeyEvent)? onKeyEvent;
  final void Function(String)? onChanged;
  final void Function()? onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppNum.inputH,
      padding: padding ??
          const EdgeInsets.only(left: AppNum.inputP, right: AppNum.smallG),
      // margin: margin ?? const EdgeInsets.symmetric(horizontal: AppNum.inputP),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .1), blurRadius: 2)
        ],
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        spacing: AppNum.smallG,
        children: [
          if (leading != null) leading!,
          Expanded(
            child: child ??
                KeyboardListener(
                  focusNode: FocusNode(),
                  onKeyEvent: onKeyEvent,
                  child: TextField(
                    controller: controller,
                    enabled: enable,
                    // style: textStyle,
                    // // focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: hintText,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                    textAlign: textAlign,
                    inputFormatters: inputFormatters,
                    onChanged: onChanged,
                    maxLines: maxLines,
                    // onEditingComplete: onEditingComplete,
                    // onSubmitted: onSubmitted,
                  ),
                ),
          ),
          if (showClear)
            ClickIcon(
              icon: Icons.close_rounded,
              color: Colors.black54,
              onTap: onClear,
            ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
