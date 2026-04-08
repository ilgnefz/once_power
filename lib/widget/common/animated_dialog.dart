import 'package:flutter/material.dart';

class AnimatedDialog extends StatefulWidget {
  final Widget child;
  final bool barrierDismissible;
  final Color barrierColor;

  const AnimatedDialog({
    super.key,
    required this.child,
    this.barrierDismissible = true,
    this.barrierColor = const Color(0x80000000),
  });

  @override
  State<AnimatedDialog> createState() => _AnimatedDialogState();

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
    Color barrierColor = const Color(0x80000000),
  }) async {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'dialog',
      barrierColor: barrierColor,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return AnimatedDialog(
          barrierDismissible: barrierDismissible,
          barrierColor: barrierColor,
          child: child,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        );
      },
    );
  }
}

class _AnimatedDialogState extends State<AnimatedDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.child,
    );
  }
}
