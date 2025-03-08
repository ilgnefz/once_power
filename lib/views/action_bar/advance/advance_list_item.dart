import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/widgets/common/click_icon.dart';

import 'advance_add_card.dart';
import 'advance_delete_card.dart';
import 'advance_replace_card.dart';

class AdvanceListItem extends StatefulWidget {
  const AdvanceListItem(this.menu, {super.key});

  final AdvanceMenuModel menu;

  @override
  State<AdvanceListItem> createState() => _AdvanceListItemState();
}

class _AdvanceListItemState extends State<AdvanceListItem> {
  final double size = 20;
  final double iconSize = 16;
  final Color iconColor = Colors.grey;
  bool isHover = false;

  void onHover(PointerHoverEvent event) {
    isHover = true;
    setState(() {});
  }

  void onExit(PointerExitEvent event) {
    isHover = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
      onHover: onHover,
      onExit: onExit,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 32,
        padding: EdgeInsets.only(left: AppNum.mediumG, right: AppNum.smallG),
        decoration: BoxDecoration(
          color: isHover ? Colors.grey.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(AppNum.smallG),
        ),
        child: Row(
          children: [
            Text(widget.menu.type.label,
                style: TextStyle(color: widget.menu.type.color)),
            SizedBox(width: AppNum.mediumG),
            buildInfo(widget.menu),
            SizedBox(width: AppNum.mediumG),
            AnimatedOpacity(
              opacity: isHover ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: Consumer(
                builder: (context, ref, child) => ClickIcon(
                  size: size,
                  iconSize: iconSize,
                  icon: Icons.copy_all_rounded,
                  color: iconColor,
                  onTap: () {
                    AdvanceMenuModel menu =
                        widget.menu.copyWith(id: nanoid(10));
                    ref.read(advanceMenuListProvider.notifier).add(menu);
                    updateName(ref);
                  },
                ),
              ),
            ),
            SizedBox(width: AppNum.smallG),
            Consumer(
              builder: (context, ref, _) => ClickIcon(
                size: size,
                iconSize: iconSize,
                icon: Icons.edit_note_rounded,
                color: iconColor,
                onTap: () {
                  if (widget.menu.type.isDelete) {
                    deleteText(context, widget.menu as AdvanceMenuDelete);
                  }
                  if (widget.menu.type.isAdd) {
                    addText(context, widget.menu as AdvanceMenuAdd);
                  }
                  if (widget.menu.type.isReplace) {
                    replaceText(context, widget.menu as AdvanceMenuReplace);
                  }
                },
              ),
            ),
            SizedBox(width: 1),
            Consumer(
              builder: (context, ref, child) => ClickIcon(
                size: size,
                iconSize: iconSize,
                icon: Icons.close_rounded,
                color: iconColor,
                onTap: () {
                  ref
                      .read(advanceMenuListProvider.notifier)
                      .remove(widget.menu);
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
