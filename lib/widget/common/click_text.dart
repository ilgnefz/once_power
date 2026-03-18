import 'package:flutter/material.dart';
import 'package:once_power/config/theme/theme.dart';
import 'package:once_power/const/num.dart';

class EasyClickText extends StatelessWidget {
  const EasyClickText({
    super.key,
    required this.label,
    this.width,
    this.radius = 0.0,
    this.color,
    this.fontSize,
    required this.onPressed,
  });

  final String label;
  final double? width;
  final double radius;
  final Color? color;
  final double? fontSize;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    Widget parent({required Widget child}) => width == null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: child,
          )
        : Container(
            width: width,
            height: AppNum.widgetHeight,
            alignment: Alignment.center,
            child: child,
          );

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(borderRadius: .circular(radius)),
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          borderRadius: BorderRadius.circular(radius),
          onTap: onPressed,
          child: parent(
            child: Text(
              label,
              style: TextStyle(
                color: color ?? Theme.of(context).primaryColor,
                fontSize: fontSize ?? 13,
                fontFamily: defaultFont,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
