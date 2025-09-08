import 'package:flutter/material.dart';
import 'package:once_power/config/theme.dart';

class EasyClickText extends StatelessWidget {
  const EasyClickText({
    super.key,
    required this.label,
    this.color,
    this.fontSize,
    required this.onTap,
  });

  final String label;
  final Color? color;
  final double? fontSize;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Text(
            label,
            style: TextStyle(
              color: color ?? Theme.of(context).primaryColor,
              fontSize: fontSize,
              fontFamily: defaultFont,
            ),
          ),
        ),
      ),
    );
  }
}
