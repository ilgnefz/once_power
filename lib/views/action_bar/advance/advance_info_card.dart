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
    bool isDeleteType = menu.deleteTypes.isNotEmpty;
    return AdvanceRichText(
      text: TextSpan(
        text: isDeleteType ? '' : menu.matchLocation.value,
        style: defaultStyle,
        children: [
          if (isDeleteType)
            ...List.generate(menu.deleteTypes.length, (index) {
              String delimiter = index == menu.deleteTypes.length - 1
                  ? ''
                  : S.of(context).delimiter;
              return TextSpan(
                text: '${menu.deleteTypes[index].value}$delimiter',
                style: highlightStyle,
              );
            }),
          if (!isDeleteType)
            menu.matchLocation.isPosition
                ? TextSpan(
                    text: '${S.of(context).position} ${menu.start} ',
                    children: [
                      TextSpan(
                        text: S.of(context).to,
                        style: defaultStyle,
                      ),
                      TextSpan(
                        text: ' ${menu.end}',
                        style: highlightStyle,
                      ),
                    ],
                    style: highlightStyle,
                  )
                : TextSpan(text: ' "${menu.value}"', style: highlightStyle),
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
      String posStr = menu.addPosition.isPosition
          ? '${S.of(context).position} ${menu.posIndex}'
          : menu.addPosition.value;
      return AdvanceRichText(
        text: TextSpan(
          text: ' "${menu.value}" ',
          style: highlightStyle,
          children: [
            TextSpan(
              text: '${S.of(context).to} ',
              style: defaultStyle,
            ),
            TextSpan(
              text: posStr,
              style: highlightStyle,
            )
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
    bool isFormat = menu.replaceMode.isFormat;
    return AdvanceRichText(
      text: TextSpan(
        text: isFormat
            ? S.of(context).formatDesc1
            : menu.caseType.isNoConversion
                ? menu.matchLocation.value
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
            TextSpan(text: ' "${menu.caseType.value}"', style: highlightStyle),
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
