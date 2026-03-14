import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/widget/action/advance_rich_text.dart';

class MatchContentCard<T> extends StatelessWidget {
  const MatchContentCard({
    super.key,
    required this.value,
    required this.number,
    required this.front,
    required this.behind,
    required this.matchContent,
    required this.matchPosition,
    required this.defaultColor,
    required this.highlightColor,
    this.children,
  });

  final String value;
  final int number;
  final int front;
  final int behind;
  final MatchContent matchContent;
  final MatchPosition matchPosition;
  final Color defaultColor;
  final Color highlightColor;
  final List<InlineSpan>? children;

  @override
  Widget build(BuildContext context) {
    switch (matchContent) {
      case MatchContent.last:
      case MatchContent.all:
        return AdvanceRichText(
          text: advanceTextSpan(
            '${matchContent.label} "',
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
            '${matchContent.label} ',
            color: defaultColor,
            children: [
              advanceTextSpan('$number', color: highlightColor),
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
    if (!matchPosition.isSelf) {
      return [
        advanceTextSpan(' ${matchPosition.label} ', color: defaultColor),
        advanceTextSpan(
          '${matchPosition.isFront ? front : behind}',
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
