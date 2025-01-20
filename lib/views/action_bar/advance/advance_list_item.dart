import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/advance.dart';
import 'package:once_power/model/advance_menu.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/views/action_bar/advance/advance_info_card.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class AdvanceListItem extends StatelessWidget {
  const AdvanceListItem(this.menu, {super.key});

  final AdvanceMenuModel menu;

  @override
  Widget build(BuildContext context) {
    final double size = 20;
    final double iconSize = 16;
    final Color iconColor = Colors.grey;
    final Color highlightColor = Theme.of(context).primaryColor;
    final TextStyle highlightStyle =
        TextStyle(color: highlightColor).useSystemChineseFont();
    final TextStyle defaultStyle =
        TextStyle(color: Colors.black).useSystemChineseFont();

    Widget buildInfo(AdvanceMenuModel menu) {
      if (menu.type.isDelete) {
        return AdvanceDeleteCard(
          menu as AdvanceMenuDelete,
          highlightStyle: highlightStyle,
          defaultStyle: defaultStyle,
        );
      } else if (menu.type.isAdd) {
        return AdvanceAddCard(
          menu as AdvanceMenuAdd,
          highlightStyle: highlightStyle,
          defaultStyle: defaultStyle,
        );
      } else {
        return AdvanceReplaceCard(
          menu as AdvanceMenuReplace,
          highlightStyle: highlightStyle,
          defaultStyle: defaultStyle,
        );
      }
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: AppNum.mediumG),
        color: Colors.white,
        child: Row(
          children: [
            Text(menu.type.value, style: TextStyle(color: menu.type.color)),
            SizedBox(width: AppNum.mediumG),
            buildInfo(menu),
            SizedBox(width: AppNum.mediumG),
            Consumer(
              builder: (context, ref, _) => ClickIcon(
                size: size,
                iconSize: iconSize,
                icon: Icons.edit_note_rounded,
                color: iconColor,
                onTap: () {
                  if (menu.type.isDelete) {
                    deleteText(context, ref, menu as AdvanceMenuDelete);
                  }
                  if (menu.type.isAdd) {
                    addText(context, ref, menu as AdvanceMenuAdd);
                  }
                  if (menu.type.isReplace) {
                    replaceText(context, ref, menu as AdvanceMenuReplace);
                  }
                },
              ),
            ),
            Consumer(
              builder: (context, ref, child) => ClickIcon(
                size: size,
                iconSize: iconSize,
                icon: Icons.close_rounded,
                color: iconColor,
                onTap: () {
                  ref.read(advanceMenuListProvider.notifier).remove(menu);
                  advanceUpdateName(ref);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
