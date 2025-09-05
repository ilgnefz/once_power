import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/provider/toggle.dart';

class DialogBackground extends ConsumerWidget {
  const DialogBackground({
    super.key,
    required this.child,
    this.action,
    this.onModelTap,
    this.onSecondaryTapDown,
  });

  final Widget child;
  final Widget? action;
  final void Function()? onModelTap;
  final void Function(TapDownDetails)? onSecondaryTapDown;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Positioned.fill(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                onModelTap?.call();
              },
              onSecondaryTapDown: onSecondaryTapDown,
              child: Consumer(
                builder: (context, ref, child) {
                  double value = ref.watch(isMaxProvider) ? 0.0 : 8.0;
                  return Container(
                    margin: EdgeInsets.all(value),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(value),
                      color: Theme.of(context).dialogTheme.backgroundColor,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Center(child: child),
        ?action,
      ],
    );
  }
}
