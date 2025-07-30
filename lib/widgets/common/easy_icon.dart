import 'package:flutter/material.dart';
import 'package:once_power/widgets/base/svg_icon.dart';

class EasyIcon extends StatefulWidget {
  const EasyIcon({
    super.key,
    this.icon,
    this.svg,
    this.size,
    this.iconSize,
    this.color,
    this.shadows,
    this.showInk = false,
  }) : assert(icon != null || svg != null);

  final IconData? icon;
  final String? svg;
  final double? size;
  final double? iconSize;
  final Color? color;
  final List<Shadow>? shadows;
  final bool showInk;

  @override
  State<EasyIcon> createState() => _EasyIconState();
}

class _EasyIconState extends State<EasyIcon> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    Widget child = widget.icon != null
        ? FittedBox(
            child: Icon(widget.icon,
                size: widget.iconSize,
                color: widget.color,
                shadows: widget.shadows),
          )
        : SvgIcon(widget.svg!, size: widget.iconSize, color: widget.color);

    if (widget.showInk) {
      child = MouseRegion(
        onHover: (e) => setState(() => show = true),
        onExit: (e) => setState(() => show = false),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: show ? Theme.of(context).hoverColor : Colors.transparent,
          ),
          alignment: Alignment.center,
          child: child,
        ),
      );
    }

    return child;
  }
}
