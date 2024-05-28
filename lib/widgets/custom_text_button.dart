import 'package:flutter/material.dart';
import 'package:once_power/constants/colors.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
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
        height: height ?? 32,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding ?? 12.0),
            child: Center(
              child: Text(
                label,
                style: style ?? const TextStyle(color: AppColors.primary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
