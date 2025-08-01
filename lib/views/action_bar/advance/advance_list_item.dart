import 'dart:io';

import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/widgets/action_bar/directive_item_btn.dart';
import 'package:once_power/widgets/action_bar/dynamic_show_btn.dart';

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
    final theme = Theme.of(context);
    final TextStyle highlightStyle = TextStyle(
      color: widget.menu.checked ? theme.primaryColor : theme.iconTheme.color,
      fontFamily: Platform.isWindows ? 'Microsoft YaHei' : null,
    ).useSystemChineseFont();
    final TextStyle defaultStyle = TextStyle(
      color: widget.menu.checked
          ? theme.textTheme.bodyMedium?.color
          : theme.iconTheme.color,
      fontFamily: Platform.isWindows ? 'Microsoft YaHei' : null,
    ).useSystemChineseFont();

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
          color: isHover ? Colors.grey.withValues(alpha: .2) : null,
          borderRadius: BorderRadius.circular(AppNum.smallG),
        ),
        child: Row(
          children: [
            Text(
              widget.menu.type.label,
              style: TextStyle(
                color: widget.menu.checked
                    ? widget.menu.type.color
                    : theme.iconTheme.color,
              ),
            ),
            SizedBox(width: AppNum.mediumG),
            buildInfo(widget.menu),
            SizedBox(width: AppNum.mediumG),
            Consumer(
              builder: (_, ref, __) => DynamicShowBtn(
                isHover: isHover,
                icon: widget.menu.checked
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                onTap: () {
                  ref
                      .read(advanceMenuListProvider.notifier)
                      .toggle(widget.menu);
                  updateName(ref);
                },
              ),
            ),
            SizedBox(width: AppNum.smallG),
            Consumer(
              builder: (_, ref, __) => DynamicShowBtn(
                isHover: isHover,
                icon: Icons.copy_all_rounded,
                onTap: () {
                  AdvanceMenuModel menu = widget.menu.copyWith(id: nanoid(10));
                  ref.read(advanceMenuListProvider.notifier).add(menu);
                  updateName(ref);
                },
              ),
            ),
            SizedBox(width: AppNum.smallG),
            Consumer(
              builder: (context, ref, _) => DynamicShowBtn(
                isHover: isHover,
                icon: Icons.edit_note_rounded,
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
              builder: (context, ref, child) => DirectiveItemBtn(
                icon: Icons.close_rounded,
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
