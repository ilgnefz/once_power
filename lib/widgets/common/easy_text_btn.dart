import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';

class EasyTextBtn extends StatelessWidget {
  const EasyTextBtn(
    this.label, {
    super.key,
    this.style,
    this.height,
    this.padding,
    required this.onTap,
  });

  final String label;
  final TextStyle? style;
  final double? height;
  final double? padding;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        height: height ?? AppNum.inputH,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: padding ?? AppNum.defaultP),
            child: Center(
              child: Text(
                label,
                style: style ??
                    const TextStyle(color: AppColors.primary)
                        .useSystemChineseFont(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
