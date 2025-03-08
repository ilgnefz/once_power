import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/widgets/action_bar/advance_rich_text.dart';

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
    bool isDeleteExt = menu.deleteExt;
    return AdvanceRichText(
      text: TextSpan(
        text: (isDeleteType || isDeleteExt) ? '' : menu.matchLocation.label,
        style: defaultStyle,
        children: [
          if (isDeleteExt)
            TextSpan(text: S.of(context).extension, style: highlightStyle),
          if (isDeleteType)
            ...List.generate(menu.deleteTypes.length, (index) {
              String delimiter = index == menu.deleteTypes.length - 1
                  ? ''
                  : S.of(context).delimiter;
              return TextSpan(
                text: '${menu.deleteTypes[index].label}$delimiter',
                style: highlightStyle,
              );
            }),
          if (!isDeleteType && !isDeleteExt)
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
