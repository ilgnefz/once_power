import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/widgets/action_bar/advance_rich_text.dart';

class AdvanceDeleteCard extends StatelessWidget {
  const AdvanceDeleteCard(
    this.menu, {
    super.key,
    required this.highlightStyle,
    required this.defaultStyle,
  });

  final AdvanceMenuDelete menu;
  final TextStyle highlightStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    bool isDeleteType = menu.deleteTypes.isNotEmpty;
    bool isDeleteExt = menu.deleteExt;

    if (isDeleteExt) {
      return AdvanceRichText(
        text: TextSpan(text: S.of(context).extension, style: highlightStyle),
      );
    }

    if (isDeleteType) {
      return AdvanceRichText(
        text: TextSpan(
          children: List.generate(menu.deleteTypes.length, (index) {
            String delimiter = index == menu.deleteTypes.length - 1
                ? ''
                : S.of(context).delimiter;
            return TextSpan(
              text: '${menu.deleteTypes[index].label}$delimiter',
              style: highlightStyle,
            );
          }),
        ),
      );
    }

    if (menu.matchLocation.isPosition) {
      return AdvanceRichText(
        text: TextSpan(
          text: menu.matchLocation.label,
          style: defaultStyle,
          children: [
            TextSpan(
              text: '${S.of(context).position} ${menu.start} ',
              children: [
                TextSpan(text: S.of(context).to, style: defaultStyle),
                TextSpan(text: ' ${menu.end}', style: highlightStyle),
              ],
              style: highlightStyle,
            ),
          ],
        ),
      );
    }

    if (menu.matchLocation.isFront || menu.matchLocation.isBack) {
      int label = menu.matchLocation.isFront ? menu.front : menu.back;
      return AdvanceRichText(
        text: TextSpan(
          text: S.of(context).first,
          style: defaultStyle,
          children: [
            TextSpan(text: ' "${menu.value}" ', style: highlightStyle),
            TextSpan(
              text: menu.matchLocation.label.substring(0, 1),
              style: defaultStyle,
            ),
            TextSpan(text: ' "$label" ', style: highlightStyle),
            TextSpan(text: S.of(context).place, style: defaultStyle),
          ],
        ),
      );
    }

    return AdvanceRichText(
      text: TextSpan(
        text: menu.matchLocation.label,
        style: defaultStyle,
        children: [TextSpan(text: ' "${menu.value}"', style: highlightStyle)],
      ),
    );
  }
}
