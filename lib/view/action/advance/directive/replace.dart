import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/config/theme/directive.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/advance_replace.dart';
import 'package:once_power/widget/action/advance_rich_text.dart';

import 'match_content.dart';

class ReplaceCard extends StatelessWidget {
  const ReplaceCard({super.key, required this.menu});

  final AdvanceMenuReplace menu;

  @override
  Widget build(BuildContext context) {
    final DirectiveTheme theme = Theme.of(context).extension<DirectiveTheme>()!;

    final Set<WidgetState> states = {
      menu.checked ? WidgetState.selected : WidgetState.disabled,
    };

    final Color defaultColor = theme.defaultColor.resolve(states);
    final Color highlightColor = theme.heightLight.resolve(states);

    switch (menu.mode) {
      case ReplaceMode.normal:
        return MatchContentCard(
          value: menu.value[0],
          match: menu.match,
          defaultColor: defaultColor,
          highlightColor: highlightColor,
          children: [
            advanceTextSpan(
              ' ${tr(AppL10n.advanceWithT)} "',
              color: defaultColor,
            ),
            advanceTextSpan(menu.value[1], color: highlightColor),
            advanceTextSpan('"', color: defaultColor),
          ],
        );
      case ReplaceMode.convert:
        return AdvanceRichText(
          text: advanceTextSpan(
            tr(AppL10n.advanceLetters),
            color: defaultColor,
            children: [
              advanceTextSpan(' "', color: defaultColor),
              advanceTextSpan(menu.convertType.label, color: highlightColor),
              advanceTextSpan('"', color: defaultColor),
            ],
          ),
        );
      case ReplaceMode.format:
        String text = int.tryParse(menu.value[0]) == null
            ? menu.value[0].length.toString()
            : menu.value[0].toString();
        return AdvanceRichText(
          text: advanceTextSpan(
            tr(AppL10n.advanceFormatDesc1),
            color: defaultColor,
            children: [
              advanceTextSpan(' $text ', color: highlightColor),
              advanceTextSpan(
                tr(AppL10n.advanceFormatDesc2),
                color: defaultColor,
              ),
              advanceTextSpan(' "', color: defaultColor),
              advanceTextSpan('${menu.value[1]}', color: highlightColor),
              advanceTextSpan(
                '" ${menu.fillPosition.label}',
                color: defaultColor,
              ),
            ],
          ),
        );
      case ReplaceMode.position:
        final (int start, int length) = (menu.start, menu.length);
        int end = start + length - 1;
        return AdvanceRichText(
          text: advanceTextSpan(
            tr(AppL10n.advancePosition),
            color: defaultColor,
            children: [
              advanceTextSpan(' $start ', color: highlightColor),
              if (end > start) ...[
                advanceTextSpan(tr(AppL10n.advanceTo), color: defaultColor),
                advanceTextSpan(' $end ', color: highlightColor),
              ],
              advanceTextSpan(
                '${tr(AppL10n.advanceWithT)} "',
                color: defaultColor,
              ),
              advanceTextSpan(menu.value[1], color: highlightColor),
              advanceTextSpan('"', color: defaultColor),
            ],
          ),
        );
      case ReplaceMode.separator:
        return AdvanceRichText(
          text: advanceTextSpan(
            '"',
            color: defaultColor,
            children: [
              advanceTextSpan(menu.wordSpacing, color: highlightColor),
              advanceTextSpan(
                '" ${tr(AppL10n.advanceSeparate)}',
                color: defaultColor,
              ),
            ],
          ),
        );
    }
  }
}
