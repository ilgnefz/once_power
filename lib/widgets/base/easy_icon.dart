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
  }) : assert(icon != null || svg != null);

  final IconData? icon;
  final String? svg;
  final double? size;
  final double? iconSize;
  final Color? color;

  @override
  State<EasyIcon> createState() => _EasyIconState();
}

class _EasyIconState extends State<EasyIcon> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    Widget child = widget.icon != null
        ? Icon(widget.icon, size: widget.iconSize, color: widget.color)
        : SvgIcon(widget.svg!, size: widget.iconSize, color: widget.color);
    return child;
  }
}
