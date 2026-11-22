import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/text.dart';

class DialogItem extends StatelessWidget {
  const DialogItem({
    super.key,
    required this.title,
    this.padding,
    this.spacing = 0.0,
    this.runSpacing = AppNumber.spaceSmall,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    required this.children,
  });

  final String title;
  final EdgeInsetsGeometry? padding;
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
        Container(
          padding: padding ?? .zero,
          height: AppNumber.widgetHeight,
          alignment: .centerLeft,
          child: BaseText('$title: '),
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

class SelectedBox extends StatelessWidget {
  const SelectedBox({super.key, required this.selected, required this.child});

  final bool selected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: selected ? 1.0 : .6,
      child: child,
    );
  }
}
