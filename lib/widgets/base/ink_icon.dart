import 'package:flutter/material.dart';
import 'package:once_power/widgets/base/easy_icon.dart';

class InkIcon extends StatefulWidget {
  const InkIcon({
    super.key,
    this.icon,
    this.svg,
    this.size,
    this.iconSize,
    this.color,
  });

  final IconData? icon;
  final String? svg;
  final double? size;
  final double? iconSize;
  final Color? color;

  @override
  State<InkIcon> createState() => _InkIconState();
}

class _InkIconState extends State<InkIcon> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (e) => setState(() => hover = true),
      onExit: (e) => setState(() => hover = false),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: hover ? Theme.of(context).hoverColor : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: EasyIcon(
          icon: widget.icon,
          svg: widget.svg,
          size: widget.size,
          iconSize: widget.iconSize,
          color: widget.color,
        ),
      ),
    );
  }
}
