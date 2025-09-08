import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';

class EasyTextBtn extends StatelessWidget {
  const EasyTextBtn(
    this.label, {
    super.key,
    this.width,
    this.fontSize = 13,
    required this.onPressed,
  });

  final String label;
  final double? width;
  final double? fontSize;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: AppNum.input,
          width: width ?? AppNum.presetMenu,
          alignment: Alignment.center,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: fontSize,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
