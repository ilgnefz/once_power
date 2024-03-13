import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';

class SmallTextButton extends StatefulWidget {
  const SmallTextButton({
    super.key,
    this.onTap,
    required this.text,
    this.action,
  });

  final Function()? onTap;
  final String text;
  final Widget? action;

  @override
  State<SmallTextButton> createState() => _SmallTextButtonState();
}

class _SmallTextButtonState extends State<SmallTextButton> {
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
      style: TextStyle(fontSize: 13, color: color),
    );

    return Container(
      height: AppNum.bottomBarH,
      margin: const EdgeInsets.symmetric(horizontal: 12),
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
