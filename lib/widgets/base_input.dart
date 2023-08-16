import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/constants/constants.dart';

import 'click_icon.dart';

class BaseInput extends StatelessWidget {
  const BaseInput({
    super.key,
    this.padding,
    this.leading,
    this.controller,
    this.hintText,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    required this.show,
    this.action,
  });

  final EdgeInsets? padding;
  final Widget? leading;
  final TextEditingController? controller;
  final String? hintText;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final bool show;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppNum.inputH,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: AppNum.inputP),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 2)
        ],
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 4.0)],
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
              textAlign: textAlign,
              inputFormatters: inputFormatters,
            ),
          ),
          if (show) ...[
            const SizedBox(width: 4.0),
            ClickIcon(
              icon: Icons.close_rounded,
              onTap: () => controller!.clear(),
            ),
          ],
          if (action != null) ...[const SizedBox(width: 4.0), action!],
        ],
      ),
    );
  }
}
