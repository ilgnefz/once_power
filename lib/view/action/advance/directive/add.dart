import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/config/theme/directive.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/advance_add.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/widget/action/advance_rich_text.dart';
import 'package:once_power/widget/base/text.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key, required this.menu});

  final AdvanceMenuAdd menu;

  @override
  Widget build(BuildContext context) {
    final DirectiveTheme theme = Theme.of(context).extension<DirectiveTheme>()!;

    final Set<WidgetState> states = {
      menu.checked ? WidgetState.selected : WidgetState.disabled,
    };

    final Color defaultColor = theme.defaultColor.resolve(states);
    final Color highlightColor = theme.heightLight.resolve(states);

    List<InlineSpan> buildInlineSpan() {
      switch (menu.addPosition) {
        case AddPosition.front:
        case AddPosition.behind:
          return [
            advanceTextSpan(' ${tr(AppL10n.advanceTo)} ', color: defaultColor),
            advanceTextSpan(
              '${menu.addPosition.label} ${tr(AppL10n.advanceDi)}',
              color: defaultColor,
            ),
            advanceTextSpan(' ${menu.positionIndex} ', color: highlightColor),
            advanceTextSpan(tr(AppL10n.advancePCount), color: defaultColor),
          ];
        case AddPosition.end:
          return [
            advanceTextSpan(' ${tr(AppL10n.advanceTo)} ', color: defaultColor),
            advanceTextSpan(menu.addPosition.label, color: defaultColor),
          ];
        case AddPosition.interval:
          return [
            advanceTextSpan(' ${menu.addPosition.label}', color: defaultColor),
            advanceTextSpan(' ${menu.positionIndex} ', color: highlightColor),
            advanceTextSpan(tr(AppL10n.advancePCount), color: defaultColor),
          ];
      }
    }

    switch (menu.mode) {
      case AddMode.text:
        return AdvanceRichText(
          text: advanceTextSpan(
            '"',
            color: defaultColor,
            children: [
              advanceTextSpan('${menu.value}', color: highlightColor),
              advanceTextSpan('"', color: defaultColor),
              ...buildInlineSpan(),
            ],
          ),
        );
      case AddMode.indexes:
        return AdvanceRichText(
          text: advanceTextSpan(
            '${formatNum(menu.advanceIndex.start, menu.advanceIndex.width)} ',
            color: highlightColor,
            children: [
              advanceTextSpan(
                tr(AppL10n.advanceStartSequence),
                color: defaultColor,
              ),
              ...buildInlineSpan(),
            ],
          ),
        );
      case AddMode.random:
        if (menu.randomValue.isEmpty) {
          return AdvanceRichText(
            text: advanceTextSpan('🤡💬', color: highlightColor),
          );
        }
        return AdvanceRichText(
          text: advanceTextSpan(
            '${menu.randomLength} ',
            color: highlightColor,
            children: [
              advanceTextSpan(tr(AppL10n.advanceCount), color: defaultColor),
              advanceTextSpan(' ${menu.mode.label}', color: highlightColor),
              ...buildInlineSpan(),
            ],
          ),
        );
      case AddMode.folder:
      case AddMode.width:
      case AddMode.height:
      case AddMode.extension:
      case AddMode.group:
        return AdvanceRichText(
          text: advanceTextSpan(
            menu.mode.label,
            color: highlightColor,
            children: [...buildInlineSpan()],
          ),
        );
      case AddMode.date:
        return AdvanceRichText(
          text: advanceTextSpan(
            menu.advanceIndex.dateType.label,
            color: highlightColor,
            children: buildInlineSpan(),
          ),
        );
      case AddMode.metaData:
        return AdvanceRichText(
          text: advanceTextSpan(
            '${menu.mode.label} ${menu.metaData.type.label}',
            color: highlightColor,
            children: buildInlineSpan(),
          ),
        );
    }
  }
}
