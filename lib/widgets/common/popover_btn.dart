import 'package:flutter/material.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

class PopoverBtn extends StatefulWidget {
  const PopoverBtn({
    super.key,
    required this.placement,
    required this.child,
    required this.builder,
  });

  final Placement placement;
  final Widget child;
  final Widget Function(PopoverController) builder;

  @override
  State<PopoverBtn> createState() => _PopoverBtnState();
}

class _PopoverBtnState extends State<PopoverBtn> {
  @override
  Widget build(BuildContext context) {
    bool isHover = false;

    return TolyPopover(
      placement: widget.placement,
      overlayBuilder: (context, ctrl) => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (e) {
            ctrl.open();
            isHover = true;
            setState(() {});
          },
          onExit: (e) {
            ctrl.close();
            isHover = false;
            setState(() {});
          },
          child: Material(color: Colors.white, child: widget.builder(ctrl)),
        ),
      ),
      builder: (_, ctrl, __) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (e) => ctrl.open(),
        onExit: (e) {
          Future.delayed(const Duration(milliseconds: 200), () {
            if (!isHover) {
              ctrl.close();
            }
          });
        },
        child: widget.child,
      ),
    );
  }
}
