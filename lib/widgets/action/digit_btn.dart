import 'package:flutter/material.dart';
import 'package:once_power/config/theme/digit.dart';

class DigitBtn extends StatelessWidget {
  const DigitBtn(
    this.label, {
    super.key,
    required this.right,
    required this.onPressed,
  });

  final String label;
  final bool right;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final borderRadius = right
        ? BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          );
    return Material(
      color: Theme.of(context).extension<DigitTheme>()?.backgroundColor,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onPressed,
        child: Container(
          width: 20,
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(fontSize: 20, color: Color(0xFF999999)),
          ),
        ),
      ),
    );
  }
}
