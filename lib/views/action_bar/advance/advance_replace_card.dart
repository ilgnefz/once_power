import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/models.dart';
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
    return AdvanceRichText(
      text: TextSpan(
        text: isFormat
            ? S.of(context).formatDesc1
            : menu.caseType.isNoConversion
                ? menu.matchLocation.label
                : S.of(context).letters,
        style: defaultStyle,
        children: [
          if (isFormat) ...[
            TextSpan(text: ' "${menu.value[0]}" ', style: highlightStyle),
            TextSpan(text: S.of(context).formatDesc2),
            TextSpan(text: ' "${menu.value[1]}" ', style: highlightStyle),
            TextSpan(text: S.of(context).formatDesc3, style: highlightStyle),
          ],
          if (!isFormat &&
              menu.caseType.isNoConversion &&
              !menu.matchLocation.isPosition) ...[
            TextSpan(text: ' "${menu.value[0]}" ', style: highlightStyle),
            TextSpan(text: S.of(context).withT),
            TextSpan(text: ' "${menu.value[1]}" ', style: highlightStyle),
          ],
          if (!isFormat &&
              menu.caseType.isNoConversion &&
              menu.matchLocation.isPosition) ...[
            TextSpan(
              text: '${S.of(context).position} ${menu.start} ',
              style: highlightStyle,
            ),
            TextSpan(text: S.of(context).to, style: defaultStyle),
            TextSpan(text: ' ${menu.end} ', style: highlightStyle),
            TextSpan(text: S.of(context).withT, style: defaultStyle),
            TextSpan(text: ' ${menu.value[1]}', style: highlightStyle),
          ],
          if (!isFormat && !menu.caseType.isNoConversion) ...[
            TextSpan(text: ' "${menu.caseType.label}"', style: highlightStyle),
          ]
        ],
      ),
    );
  }
}
