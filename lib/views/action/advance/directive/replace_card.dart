import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/models/advance.dart';
import 'package:once_power/widgets/action/advance_rich_text.dart';

class AdvanceReplaceCard extends StatelessWidget {
  const AdvanceReplaceCard(
    this.menu, {
    super.key,
    required this.highlightStyle,
    required this.defaultStyle,
  });

  final AdvanceMenuReplace menu;
  final TextStyle highlightStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    bool isFormat = menu.replaceMode.isFormat;
    bool isNoCon = menu.convertType.isNoConversion;
    bool noFmtNoCon = !isFormat && isNoCon;

    if (isFormat) {
      return AdvanceRichText(
        text: TextSpan(
          text: tr(AppL10n.advanceFormatDesc1),
          style: defaultStyle,
          children: [
            TextSpan(text: ' "${menu.value[0]}" ', style: highlightStyle),
            TextSpan(text: tr(AppL10n.advanceFormatDesc2)),
            TextSpan(text: ' "${menu.value[1]}" ', style: highlightStyle),
            TextSpan(
              text: tr(AppL10n.advanceFormatDesc3),
              style: highlightStyle,
            ),
          ],
        ),
      );
    }

    if (!isFormat && menu.wordSpacing != '') {
      return AdvanceRichText(
        text: TextSpan(
          text: '"${menu.wordSpacing}" ',
          style: highlightStyle,
          children: [
            TextSpan(text: tr(AppL10n.advanceSeparate), style: defaultStyle),
          ],
        ),
      );
    }

    if (!isNoCon) {
      return AdvanceRichText(
        text: TextSpan(
          text: tr(AppL10n.advanceLetters),
          style: defaultStyle,
          children: [
            TextSpan(
              text: ' "${menu.convertType.label}"',
              style: highlightStyle,
            ),
          ],
        ),
      );
    }

    if (noFmtNoCon && menu.matchLocation.isPosition) {
      return AdvanceRichText(
        text: TextSpan(
          text: tr(AppL10n.advancePosition),
          style: defaultStyle,
          children: [
            TextSpan(text: ' ${menu.start} ', style: highlightStyle),
            TextSpan(text: tr(AppL10n.advanceTo), style: defaultStyle),
            TextSpan(text: ' ${menu.end} ', style: highlightStyle),
            TextSpan(text: tr(AppL10n.advanceWithT), style: defaultStyle),
            TextSpan(text: ' "${menu.value[1]}"', style: highlightStyle),
          ],
        ),
      );
    }

    if (noFmtNoCon &&
        (menu.matchLocation.isFront || menu.matchLocation.isBehind)) {
      String label = menu.matchLocation.isFront
          ? tr(AppL10n.advanceFrontLabel)
          : tr(AppL10n.advanceBackLabel);
      int num = menu.matchLocation.isFront ? menu.front : menu.back;
      return AdvanceRichText(
        text: TextSpan(
          text: tr(AppL10n.advanceFirst),
          style: defaultStyle,
          children: [
            TextSpan(text: ' "${menu.value[0]}" ', style: highlightStyle),
            TextSpan(text: label, style: defaultStyle),
            TextSpan(text: ' "$num" ', style: highlightStyle),
            TextSpan(text: tr(AppL10n.advancePlace), style: defaultStyle),
            TextSpan(text: tr(AppL10n.advanceWithT)),
            TextSpan(text: ' "${menu.value[1]}" ', style: highlightStyle),
          ],
        ),
      );
    }

    return AdvanceRichText(
      text: TextSpan(
        text: menu.matchLocation.label,
        style: defaultStyle,
        children: [
          TextSpan(text: ' "${menu.value[0]}" ', style: highlightStyle),
          TextSpan(text: tr(AppL10n.advanceWithT)),
          TextSpan(text: ' "${menu.value[1]}" ', style: highlightStyle),
        ],
      ),
    );
  }
}
