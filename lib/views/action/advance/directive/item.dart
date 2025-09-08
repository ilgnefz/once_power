import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/config/theme.dart';
import 'package:once_power/config/theme/directive.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/cores/context_menu.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/models/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/utils/storage.dart';

import 'add_card.dart';
import 'delete_card.dart';
import 'dynamic_btn.dart';
import 'item_btn.dart';
import 'replace_card.dart';

class AdvanceListItem extends ConsumerStatefulWidget {
  const AdvanceListItem({super.key, required this.index, required this.menu});

  final int index;
  final AdvanceMenuModel menu;

  @override
  ConsumerState<AdvanceListItem> createState() => _AdvanceListItemState();
}

class _AdvanceListItemState extends ConsumerState<AdvanceListItem> {
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
    final ThemeData theme = Theme.of(context);
    final provider = ref.read(advanceMenuListProvider.notifier);
    final TextStyle highlightStyle = TextStyle(
      color: widget.menu.checked ? theme.primaryColor : theme.iconTheme.color,
      fontFamily: defaultFont,
      fontSize: 14,
    );
    final TextStyle defaultStyle = TextStyle(
      color: widget.menu.checked
          ? theme.textTheme.bodyMedium?.color
          : theme.iconTheme.color,
      fontFamily: defaultFont,
      fontSize: 14,
    );

    List<AdvanceMenuModel> selectList = ref.watch(
      advanceMenuSelectedListProvider,
    );

    void onPointerDown(PointerDownEvent event) async {
      if (event.buttons == kPrimaryButton &&
          event.localPosition != Offset.zero) {
        Set keysPressed = HardwareKeyboard.instance.logicalKeysPressed;
        // 判断Ctrl键是否被按下（左右Ctrl均可）
        final isCtrlPressed =
            keysPressed.contains(LogicalKeyboardKey.controlLeft) ||
            keysPressed.contains(LogicalKeyboardKey.controlRight);
        // 判断Shift键是否被按下（左右Shift均可）
        final isShiftPressed =
            keysPressed.contains(LogicalKeyboardKey.shiftLeft) ||
            keysPressed.contains(LogicalKeyboardKey.shiftRight);

        if (isCtrlPressed) {
          if (selectList.contains(widget.menu)) {
            ref
                .read(advanceMenuSelectedListProvider.notifier)
                .remove(widget.menu);
          } else {
            ref.read(advanceMenuSelectedListProvider.notifier).add(widget.menu);
          }
        } else if (isShiftPressed) {
          List<AdvanceMenuModel> allMenu = ref.watch(advanceMenuListProvider);
          int beginIndex = 0;
          if (selectList.isNotEmpty) {
            AdvanceMenuModel startFile =
                StorageUtil.getBool(AppKeys.hadPressedCtrl)
                ? selectList.last
                : selectList.first;
            beginIndex = allMenu.indexOf(startFile);
          }
          List<AdvanceMenuModel> newSelectList = [];
          // 根据起始索引与当前文件索引的关系，生成连续选中区间
          if (beginIndex < widget.index) {
            // 起始索引小于当前索引时，选中[beginIndex, index]区间
            newSelectList.addAll(allMenu.sublist(beginIndex, widget.index + 1));
          } else {
            // 起始索引大于当前索引时，反向选中[index, beginIndex]区间
            newSelectList.addAll(
              allMenu.sublist(widget.index, beginIndex + 1).reversed,
            );
          }
          await StorageUtil.setBool(AppKeys.hadPressedCtrl, false);
          ref.read(advanceMenuSelectedListProvider.notifier).clear();
          ref
              .read(advanceMenuSelectedListProvider.notifier)
              .addAll(newSelectList);
        } else {
          if (selectList.contains(widget.menu) && selectList.length == 1) {
            ref.read(advanceMenuSelectedListProvider.notifier).clear();
          } else {
            ref.read(advanceMenuSelectedListProvider.notifier).one(widget.menu);
          }
          await StorageUtil.setBool(AppKeys.hadPressedCtrl, false);
        }
      }
    }

    void onSecondaryTapDown(TapDownDetails detail) async {
      if (selectList.length < 2) return;
      await showDirectiveRightMenu(context, ref, detail);
    }

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

    return Listener(
      onPointerDown: onPointerDown,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: onHover,
        onExit: onExit,
        child: InkWell(
          onDoubleTap: () {},
          onSecondaryTapDown: onSecondaryTapDown,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 32,
            padding: EdgeInsets.only(
              left: AppNum.spaceMedium,
              right: AppNum.spaceSmall,
            ),
            decoration: BoxDecoration(
              color: isHover || selectList.contains(widget.menu)
                  ? theme.extension<DirectiveTheme>()?.hoverColor
                  : null,
              borderRadius: BorderRadius.circular(AppNum.spaceSmall),
            ),
            child: Row(
              children: [
                Text(
                  widget.menu.type.label,
                  style: TextStyle(
                    color: widget.menu.checked
                        ? widget.menu.type.color
                        : theme.iconTheme.color,
                    fontSize: 14,
                    fontFamily: defaultFont,
                  ),
                ),
                SizedBox(width: AppNum.spaceMedium),
                buildInfo(widget.menu),
                SizedBox(width: AppNum.spaceMedium),
                Consumer(
                  builder: (_, ref, __) => DynamicShowBtn(
                    isHover: isHover,
                    icon: widget.menu.checked
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    onTap: () {
                      provider.toggle(widget.menu);
                      advanceUpdateName(ref);
                    },
                  ),
                ),
                SizedBox(width: AppNum.spaceSmall),
                Consumer(
                  builder: (_, ref, __) => DynamicShowBtn(
                    isHover: isHover,
                    icon: Icons.copy_all_rounded,
                    onTap: () {
                      ref.read(currentPresetNameProvider.notifier).update('');
                      AdvanceMenuModel menu = widget.menu.copyWith(
                        id: nanoid(10),
                      );
                      provider.add(menu);
                      updateName(ref);
                    },
                  ),
                ),
                SizedBox(width: AppNum.spaceSmall),
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
                      ref.read(currentPresetNameProvider.notifier).update('');
                      provider.remove(widget.menu);
                      advanceUpdateName(ref);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
