import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';

class DetailDialog extends StatelessWidget {
  const DetailDialog({super.key, required this.child, this.padding});

  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    return UnconstrainedBox(
      child: Material(
        borderRadius: borderRadius,
        color: Colors.white,
        child: Container(
          width: AppNum.detailDialogW,
          height: MediaQuery.of(context).size.height * .85,
          padding: padding ?? const EdgeInsets.all(AppNum.detailDialogP),
          decoration: BoxDecoration(borderRadius: borderRadius),
          child: child,
        ),
      ),
    );
  }
}
