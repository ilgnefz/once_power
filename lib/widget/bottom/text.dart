import 'package:flutter/material.dart';
import 'package:once_power/config/theme/bottom_text.dart';
import 'package:once_power/config/theme/theme.dart';

class BottomTextButton extends StatefulWidget {
  const BottomTextButton(this.label, {super.key, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  State<BottomTextButton> createState() => _BottomTextButtonState();
}

class _BottomTextButtonState extends State<BottomTextButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (e) => setState(() => isHover = true),
      onExit: (e) => setState(() => isHover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 200),
          style: theme.textTheme.labelMedium!.copyWith(
            fontSize: 13,
            color: isHover
                ? theme.primaryColor
                : theme.extension<BottomTextTheme>()?.textStyle.color,
            fontFamily: defaultFont,
            height: 2,
          ),
          child: Text(widget.label, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
