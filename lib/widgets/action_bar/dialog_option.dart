import 'package:flutter/material.dart';

class DialogOption extends StatelessWidget {
  const DialogOption({
    super.key,
    required this.title,
    required this.padding,
    this.spacing,
    this.runSpacing,
    this.alignment,
    this.crossAxisAlignment,
    required this.children,
  });

  final String title;
  final EdgeInsetsGeometry padding;
  final double? spacing;
  final double? runSpacing;
  final WrapAlignment? alignment;
  final WrapCrossAlignment? crossAxisAlignment;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: padding, child: Text(title)),
        Expanded(
          child: Wrap(
            spacing: spacing ?? 0.0,
            runSpacing: runSpacing ?? 0.0,
            alignment: alignment ?? WrapAlignment.start,
            crossAxisAlignment: crossAxisAlignment ?? WrapCrossAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }
}
