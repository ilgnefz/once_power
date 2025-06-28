import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';

class EasyBtn extends StatelessWidget {
  const EasyBtn(
    this.label, {
    super.key,
    this.height,
    this.padding,
    this.fontSize,
    required this.onTap,
  });

  final String label;
  final double? height;
  final double? padding;
  final double? fontSize;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.0);
    final theme = Theme.of(context);

    return Material(
      borderRadius: borderRadius,
      color: theme.colorScheme.surface,
      child: Ink(
        height: height ?? AppNum.inputH,
        decoration: BoxDecoration(borderRadius: borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: padding ?? AppNum.defaultP),
            decoration: BoxDecoration(borderRadius: borderRadius),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(color: theme.primaryColor, fontSize: fontSize)
                  .useSystemChineseFont(),
            ),
          ),
        ),
      ),
    );
  }
}
