import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/widget/action/advance_rich_text.dart';

class MatchContentCard<T> extends StatelessWidget {
  const MatchContentCard({
    super.key,
    required this.value,
    required this.match,
    required this.defaultColor,
    required this.highlightColor,
    this.children,
  });

  final String value;
  final AdvanceMatch match;
  final Color defaultColor;
  final Color highlightColor;
  final List<InlineSpan>? children;

  @override
  Widget build(BuildContext context) {
    switch (match.content) {
      case MatchContent.last:
      case MatchContent.all:
        return AdvanceRichText(
          text: advanceTextSpan(
            '${match.content.label} "',
            color: defaultColor,
            children: [
              advanceTextSpan(value, color: highlightColor),
              advanceTextSpan('"', color: defaultColor),
              ...matchPositionLabel(),
              ...?children,
            ],
          ),
        );
      case MatchContent.number:
        return AdvanceRichText(
          text: advanceTextSpan(
            '${match.content.label} ',
            color: defaultColor,
            children: [
              advanceTextSpan('${match.contentIndex}', color: highlightColor),
              advanceTextSpan(
                ' ${tr(AppL10n.advanceGe)} "',
                color: defaultColor,
              ),
              advanceTextSpan(value, color: highlightColor),
              advanceTextSpan('"', color: defaultColor),
              ...matchPositionLabel(),
              ...?children,
            ],
          ),
        );
    }
  }

  List<InlineSpan> matchPositionLabel() {
    if (!match.position.isSelf) {
      return [
        advanceTextSpan(' ${match.position.label} ', color: defaultColor),
        advanceTextSpan(
          '${match.position.isFront ? match.frontIndex : match.behindIndex}',
          color: highlightColor,
        ),
        advanceTextSpan(' ${tr(AppL10n.advanceCount)}', color: defaultColor),
      ];
    }
    return [];
  }
}

// case MatchPosition.front:
// case MatchPosition.behind:
// return AdvanceRichText(
// text: advanceTextSpan(
// '"',
// color: defaultColor,
// children: [
// advanceTextSpan(value, color: highlightColor),
// advanceTextSpan('" ${matchContent.label} ', color: defaultColor),
// advanceTextSpan(
// '${matchContent.isFront ? front : behind}',
// color: highlightColor,
// ),
// advanceTextSpan(
// ' ${tr(AppL10n.advanceCount)}',
// color: defaultColor,
// ),
// ...?children,
// ],
// ),
// );
