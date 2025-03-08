import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';

class TextBtn extends StatefulWidget {
  const TextBtn({
    super.key,
    this.onTap,
    required this.text,
    this.margin,
    this.action,
  });

  final Function()? onTap;
  final String text;
  final EdgeInsets? margin;
  final Widget? action;

  @override
  State<TextBtn> createState() => _TextBtnState();
}

class _TextBtnState extends State<TextBtn> {
  bool hover = false;

  void onHover(bool v) {
    hover = v;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Color color = hover ? Theme.of(context).primaryColor : Colors.grey;
    final text = Text(
      widget.text,
      style: TextStyle(fontSize: 13, color: color).useSystemChineseFont(),
    );

    return Container(
      margin: widget.margin,
      height: AppNum.bottomBarH,
      alignment: Alignment.center,
      child: InkWell(
        onHover: onHover,
        onTap: widget.onTap,
        child: widget.action != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [text, widget.action!],
              )
            : text,
      ),
    );
  }
}
