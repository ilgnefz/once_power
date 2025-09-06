import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/models/advance.dart';
import 'package:once_power/widgets/action/advance_rich_text.dart';

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
        text: TextSpan(text: tr(AppL10n.advanceExt), style: highlightStyle),
      );
    }

    if (isDeleteType) {
      return AdvanceRichText(
        text: TextSpan(
          children: List.generate(menu.deleteTypes.length, (index) {
            String delimiter = index == menu.deleteTypes.length - 1
                ? ''
                : tr(AppL10n.advanceDelimiter);
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
          text: tr(AppL10n.advancePosition),
          style: defaultStyle,
          children: [
            TextSpan(
              text: ' ${menu.start} ',
              children: [
                TextSpan(text: tr(AppL10n.advanceTo), style: defaultStyle),
                TextSpan(text: ' ${menu.end}', style: highlightStyle),
              ],
              style: highlightStyle,
            ),
          ],
        ),
      );
    }

    if (menu.matchLocation.isFront || menu.matchLocation.isBehind) {
      String label = menu.matchLocation.isFront
          ? tr(AppL10n.advanceFrontLabel)
          : tr(AppL10n.advanceBackLabel);
      int num = menu.matchLocation.isFront ? menu.front : menu.back;
      return AdvanceRichText(
        text: TextSpan(
          text: tr(AppL10n.advanceFirst),
          style: defaultStyle,
          children: [
            TextSpan(text: ' "${menu.value}" ', style: highlightStyle),
            TextSpan(text: label, style: defaultStyle),
            TextSpan(text: ' "$num" ', style: highlightStyle),
            TextSpan(text: tr(AppL10n.advancePlace), style: defaultStyle),
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
