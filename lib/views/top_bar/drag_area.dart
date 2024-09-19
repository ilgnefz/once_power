import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class DragArea extends StatelessWidget {
  const DragArea({
    super.key,
    required this.child,
    this.onDoubleTap,
  });

  final Widget child;
  final void Function()? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) {
        windowManager.startDragging();
      },
      onDoubleTap: onDoubleTap,
      child: child,
    );
  }
}
