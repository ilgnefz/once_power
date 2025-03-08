import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/widgets/action_bar/advance_rich_text.dart';

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
    if (!menu.addType.isSerialNumber) {
      String startStr =
          menu.addType.isText ? '"${menu.value}"' : menu.addType.label;
      return AdvanceRichText(
        text: TextSpan(
          text: startStr,
          style: highlightStyle,
          children: [
            TextSpan(
              text: ' ${S.of(context).to} ',
              style: defaultStyle,
            ),
            TextSpan(
              text: menu.addPosition.label,
              style: highlightStyle,
            ),
            TextSpan(
              text: ' ${S.of(context).di} ',
              style: defaultStyle,
            ),
            TextSpan(
              text: '${menu.posIndex} ',
              style: highlightStyle,
            ),
            TextSpan(
              text: S.of(context).place,
              style: defaultStyle,
            ),
          ],
        ),
      );
    }
    return AdvanceRichText(
      text: TextSpan(
        text: ' "${formatNum(menu.start, menu.digits)}" ',
        style: highlightStyle,
        children: [
          TextSpan(
            text: S.of(context).startSequence,
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: ' ${S.of(context).to} ',
            style: defaultStyle,
          ),
          TextSpan(
            text: menu.addPosition.label,
            style: highlightStyle,
          )
        ],
      ),
    );
  }
}
