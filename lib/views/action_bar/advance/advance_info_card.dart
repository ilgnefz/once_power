import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/advance_menu.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/utils/format.dart';

class AdvanceDeleteCard extends StatelessWidget {
  const AdvanceDeleteCard(
    this.menu, {
    super.key,
    required this.highlightStyle,
    required this.defaultStyle,
  });

  final AdvanceMenuDelete menu;
  final TextStyle highlightStyle;
  final TextStyle defaultStyle;

  @override
  Widget build(BuildContext context) {
    return AdvanceRichText(
      text: TextSpan(
        text: menu.matchLocation.value,
        style: defaultStyle,
        children: [
          TextSpan(
            text: ' "${menu.value}"',
            style: highlightStyle,
          ),
        ],
      ),
    );
  }
}

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
    if (menu.addType.isText) {
      return AdvanceRichText(
        text: TextSpan(
          text: ' "${menu.value}" ',
          style: highlightStyle,
          children: [
            TextSpan(
              text: '${S.of(context).to} ${menu.addPosition.value}',
              style: defaultStyle,
            ),
          ],
        ),
      );
    }
    return AdvanceRichText(
      text: TextSpan(
        text: ' "${formatNumber(menu.start, menu.digits)}" ',
        style: highlightStyle,
        children: [
          TextSpan(
            text: S.of(context).startSequence,
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: ' ${S.of(context).to} ${menu.addPosition.value}',
            style: defaultStyle,
          ),
        ],
      ),
    );
  }
}

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
    return AdvanceRichText(
      text: TextSpan(
        text: menu.caseType.isNoConversion
            ? menu.matchLocation.value
            : '${S.of(context).letters} ',
        style: defaultStyle,
        children: [
          if (menu.caseType.isNoConversion) ...[
            TextSpan(text: ' "${menu.value[0]}" ', style: highlightStyle),
            TextSpan(text: S.of(context).withT),
            TextSpan(text: ' "${menu.value[1]}" ', style: highlightStyle),
          ],
          if (!menu.caseType.isNoConversion) ...[
            TextSpan(text: '"${menu.caseType.value}" ', style: highlightStyle),
          ]
        ],
      ),
    );
  }
}

class AdvanceRichText extends StatelessWidget {
  const AdvanceRichText({super.key, required this.text});

  final InlineSpan text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
        text: text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
