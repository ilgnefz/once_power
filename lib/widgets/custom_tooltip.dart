import 'package:flutter/material.dart';

class CustomTooltip extends StatelessWidget {
  const CustomTooltip({
    super.key,
    required this.child,
    required this.content,
  });

  final Widget? content;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      richMessage: content == null ? null : WidgetSpan(child: content!),
      verticalOffset: 16,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(.2))
        ],
      ),
      waitDuration: const Duration(seconds: 1),
      child: child,
    );
  }
}
