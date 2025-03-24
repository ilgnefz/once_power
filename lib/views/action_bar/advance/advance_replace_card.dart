import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/widgets/action_bar/advance_rich_text.dart';

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
    bool isNoCon = menu.caseType.isNoConversion;
    bool noFmtNoCon = !isFormat && isNoCon;

    if (isFormat) {
      return AdvanceRichText(
        text: TextSpan(
          text: S.of(context).formatDesc1,
          style: defaultStyle,
          children: [
            TextSpan(text: ' "${menu.value[0]}" ', style: highlightStyle),
            TextSpan(text: S.of(context).formatDesc2),
            TextSpan(text: ' "${menu.value[1]}" ', style: highlightStyle),
            TextSpan(text: S.of(context).formatDesc3, style: highlightStyle),
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
            TextSpan(text: S.of(context).separate, style: defaultStyle),
          ],
        ),
      );
    }

    if (!isNoCon) {
      return AdvanceRichText(
        text: TextSpan(
          text: S.of(context).letters,
          style: defaultStyle,
          children: [
            TextSpan(text: ' "${menu.caseType.label}"', style: highlightStyle),
          ],
        ),
      );
    }

    if (noFmtNoCon && menu.matchLocation.isPosition) {
      return AdvanceRichText(
        text: TextSpan(
          text: S.of(context).position,
          style: defaultStyle,
          children: [
            TextSpan(text: ' ${menu.start} ', style: highlightStyle),
            TextSpan(text: S.of(context).to, style: defaultStyle),
            TextSpan(text: ' ${menu.end} ', style: highlightStyle),
            TextSpan(text: S.of(context).withT, style: defaultStyle),
            TextSpan(text: ' "${menu.value[1]}"', style: highlightStyle),
          ],
        ),
      );
    }

    if (noFmtNoCon &&
        (menu.matchLocation.isFront || menu.matchLocation.isBack)) {
      String label = menu.matchLocation.isFront
          ? S.current.frontLabel
          : S.current.backLabel;
      int num = menu.matchLocation.isFront ? menu.front : menu.back;
      return AdvanceRichText(
        text: TextSpan(
          text: S.of(context).first,
          style: defaultStyle,
          children: [
            TextSpan(text: ' "${menu.value[0]}" ', style: highlightStyle),
            TextSpan(text: label, style: defaultStyle),
            TextSpan(text: ' "$num" ', style: highlightStyle),
            TextSpan(text: S.of(context).place, style: defaultStyle),
            TextSpan(text: S.of(context).withT),
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
          TextSpan(text: S.of(context).withT),
          TextSpan(text: ' "${menu.value[1]}" ', style: highlightStyle),
        ],
      ),
    );
  }
}
