import 'package:flutter/material.dart';

class DialogOption extends StatelessWidget {
  const DialogOption({
    super.key,
    required this.title,
    required this.padding,
    this.spacing = 0.0,
    this.runSpacing = 0.0,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    required this.children,
  });

  final String title;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final double runSpacing;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAxisAlignment;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: padding,
          child: Text(
            '$title: ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          child: Wrap(
            spacing: spacing,
            runSpacing: runSpacing,
            alignment: alignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          ),
        ),
      ],
    );
  }
}
