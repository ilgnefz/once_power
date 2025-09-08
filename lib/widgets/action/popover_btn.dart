import 'package:flutter/material.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

class PopoverBtn extends StatefulWidget {
  const PopoverBtn({super.key, required this.label, required this.builder});

  final String label;
  final Widget Function(PopoverController) builder;

  @override
  State<PopoverBtn> createState() => _PopoverBtnState();
}

class _PopoverBtnState extends State<PopoverBtn> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    bool isHover = false;

    return TolyPopover(
      placement: Placement.top,
      overlayBuilder: (_, ctrl) => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (_) => setState(() {
            ctrl.open();
            isHover = true;
          }),
          onExit: (_) => setState(() {
            ctrl.close();
            isHover = false;
          }),
          child: Material(color: Colors.white, child: widget.builder(ctrl)),
        ),
      ),
      builder: (_, ctrl, __) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (e) => ctrl.open(),
        onExit: (e) {
          Future.delayed(const Duration(milliseconds: 200), () {
            if (!isHover) ctrl.close();
          });
        },
        child: Text(
          widget.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
