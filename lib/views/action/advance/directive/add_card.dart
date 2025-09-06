import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/models/advance.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/widgets/action/advance_rich_text.dart';

class AdvanceAddCard extends StatelessWidget {
  const AdvanceAddCard(
    this.menu, {
    super.key,
    required this.highlightStyle,
    required this.defaultStyle,
  });

  final AdvanceMenuAdd menu;
  final TextStyle highlightStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    if (!menu.addType.isSerial) {
      String startStr = menu.addType.label;
      if (menu.addType.isText) startStr = '"${menu.value}"';
      if (menu.addType.isDate) startStr = menu.dateType.label;
      if (menu.addType.isRandom) {
        startStr =
            '${menu.addType.label} ${menu.randomLen} ${tr(AppL10n.advanceDigits)}';
      }
      if (menu.addType.isMetaData) {
        startStr = '${menu.addType.label} ${menu.metaData.label}';
      }
      return AdvanceRichText(
        text: TextSpan(
          text: startStr,
          style: highlightStyle,
          children: [
            TextSpan(text: ' ${tr(AppL10n.advanceTo)} ', style: defaultStyle),
            TextSpan(text: menu.addPosition.label, style: highlightStyle),
            TextSpan(text: ' ${tr(AppL10n.advanceDi)} ', style: defaultStyle),
            TextSpan(text: '${menu.posIndex} ', style: highlightStyle),
            TextSpan(text: tr(AppL10n.advancePlace), style: defaultStyle),
          ],
        ),
      );
    }
    return AdvanceRichText(
      text: TextSpan(
        text: ' "${formatNum(menu.start, menu.digits)}" ',
        style: highlightStyle,
        children: [
          TextSpan(text: tr(AppL10n.advanceStartSequence), style: defaultStyle),
          TextSpan(text: ' ${tr(AppL10n.advanceTo)} ', style: defaultStyle),
          TextSpan(text: menu.addPosition.label, style: highlightStyle),
        ],
      ),
    );
  }
}
