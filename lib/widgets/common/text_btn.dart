import 'package:flutter/material.dart';
import 'package:once_power/config/theme/bottom_text.dart';

class TextBtn extends StatefulWidget {
  const TextBtn(this.label, {super.key, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  State<TextBtn> createState() => _TextBtnState();
}

class _TextBtnState extends State<TextBtn> {
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
            height: 2,
          ),
          child: Text(widget.label, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
