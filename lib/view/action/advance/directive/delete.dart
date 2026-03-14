import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/config/theme/directive.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/view/action/advance/directive/match_content.dart';
import 'package:once_power/widget/action/advance_rich_text.dart';

class DeleteCard extends StatelessWidget {
  const DeleteCard({super.key, required this.menu});

  final AdvanceMenuDelete menu;

  @override
  Widget build(BuildContext context) {
    final DirectiveTheme theme = Theme.of(context).extension<DirectiveTheme>()!;

    final Set<WidgetState> states = {
      menu.checked ? WidgetState.selected : WidgetState.disabled,
    };

    final Color defaultColor = theme.defaultColor.resolve(states);
    final Color highlightColor = theme.heightLight.resolve(states);

    switch (menu.mode) {
      case DeleteMode.input:
        return MatchContentCard(
          value: menu.value,
          number: menu.number,
          front: menu.front,
          behind: menu.behind,
          matchContent: menu.matchContent,
          matchPosition: menu.matchPosition,
          defaultColor: defaultColor,
          highlightColor: highlightColor,
        );
      case DeleteMode.type:
        List<DeleteType> types = menu.deleteTypes;
        String text = types.isEmpty
            ? '👻💨'
            : types
                  .map((e) => e.label)
                  .toList()
                  .join(tr(AppL10n.advanceDelimiter));
        return AdvanceRichText(
          text: advanceTextSpan(text, color: highlightColor),
        );
      case DeleteMode.position:
        final (int start, int length) = (menu.start, menu.length);
        int end = start + length - 1;
        return AdvanceRichText(
          text: advanceTextSpan(
            tr(AppL10n.advancePosition),
            color: defaultColor,
            children: [
              advanceTextSpan(' $start', color: highlightColor),
              if (end > start) ...[
                advanceTextSpan(
                  ' ${tr(AppL10n.advanceTo)} ',
                  color: defaultColor,
                ),
                advanceTextSpan('$end', color: highlightColor),
              ],
            ],
          ),
        );
      case DeleteMode.extension:
        return AdvanceRichText(
          text: advanceTextSpan(tr(AppL10n.advanceExt), color: highlightColor),
        );
    }

    // MatchContent content = menu.matchContent;

    // switch (content) {
    // case MatchContent.position:
    //   return AdvanceRichText(
    //     text: advanceTextSpan(
    //       tr(AppL10n.advancePosition),
    //       color: defaultColor,
    //       children: [
    //         advanceTextSpan(
    //           ' ${menu.start} ',
    //           children: [
    //             advanceTextSpan(tr(AppL10n.advanceTo), color: defaultColor),
    //             advanceTextSpan(' ${menu.end}', color: highlightColor),
    //           ],
    //           color: highlightColor,
    //         ),
    //       ],
    //     ),
    //   );
    // case MatchContent.front:
    // case MatchContent.behind:
    //   int index = content.isFront ? menu.front : menu.behind;
    //   return AdvanceRichText(
    //     text: advanceTextSpan(
    //       '"${menu.value}" ',
    //       color: defaultColor,
    //       children: [
    //         advanceTextSpan(content.label, color: highlightColor),
    //         advanceTextSpan(' "$index"', color: highlightColor),
    //         advanceTextSpan(' "${menu.value}"', color: highlightColor),
    //       ],
    //     ),
    //   );
    // default:
    //   return AdvanceRichText(
    //     text: advanceTextSpan(
    //       content.label,
    //       color: defaultColor,
    //       children: [
    //         advanceTextSpan(' "${menu.value}"', color: highlightColor),
    //       ],
    //     ),
    //   );
    // }
  }
}
