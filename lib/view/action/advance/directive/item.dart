import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/context_menu.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/core/update/advance.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/advance_add.dart';
import 'package:once_power/model/advance_delete.dart';
import 'package:once_power/model/advance_replace.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/src/rust/api/file_info.dart';
import 'package:once_power/util/selection.dart';
import 'package:once_power/widget/action/dynamic_button.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/click_icon.dart';

import 'add.dart';
import 'delete.dart';
import 'replace.dart';

final Widget _spaceM = SizedBox(width: AppNum.spaceMedium);
final Widget _spaceS = SizedBox(width: AppNum.spaceSmall);

class DirectiveItem extends ConsumerStatefulWidget {
  const DirectiveItem({super.key, required this.index, required this.menu});

  final int index;
  final AdvanceMenuModel menu;

  @override
  ConsumerState<DirectiveItem> createState() => _DirectiveItemState();
}

class _DirectiveItemState extends ConsumerState<DirectiveItem> {
  bool isHover = false;

  Future<void> onSecondaryTapDown(TapDownDetails details) async {
    await showDirectiveRightMenu(context, ref, details.globalPosition);
  }

  Widget buildInfo() {
    switch (widget.menu.type) {
      case AdvanceType.delete:
        return DeleteCard(menu: widget.menu as AdvanceMenuDelete);
      case AdvanceType.add:
        return AddCard(menu: widget.menu as AdvanceMenuAdd);
      case AdvanceType.replace:
        return ReplaceCard(menu: widget.menu as AdvanceMenuReplace);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AdvanceMenuModel menu = widget.menu;
    final provider = ref.read(advanceMenuListProvider.notifier);
    Color color = menu.checked ? menu.type.color : Colors.grey;
    List<AdvanceMenuModel> selectList = ref.watch(
      advanceMenuSelectedListProvider,
    );
    BorderRadius borderRadius = .circular(AppNum.radiusSmall);
    // TODO: 深色模式下看不清
    Color? backgroundColor = selectList.contains(menu)
        ? Theme.of(context).hoverColor
        : null;

    void onPointerDown(PointerDownEvent event) {
      bool isLeft = event.buttons == kPrimaryButton;
      if (!isLeft || event.localPosition == Offset.zero) return;
      Set keys = HardwareKeyboard.instance.logicalKeysPressed;
      bool isCtrlPressed =
          keys.contains(LogicalKeyboardKey.controlLeft) ||
          keys.contains(LogicalKeyboardKey.controlRight);
      bool isShiftPressed =
          keys.contains(LogicalKeyboardKey.shiftLeft) ||
          keys.contains(LogicalKeyboardKey.shiftRight);
      final provider = ref.read(advanceMenuSelectedListProvider.notifier);

      if (isCtrlPressed) {
        SelectionState.menusUpdate(true);
        selectList.contains(menu) ? provider.remove(menu) : provider.add(menu);
      } else if (isShiftPressed) {
        List<AdvanceMenuModel> list = ref.read(advanceMenuListProvider);
        int begin = 0;
        if (selectList.isNotEmpty) {
          AdvanceMenuModel startMenu = SelectionState.menusPressedCtrl
              ? selectList.last
              : selectList.first;
          begin = list.indexOf(startMenu);
        }
        List<AdvanceMenuModel> newSelectList = [];
        begin < widget.index
            ? newSelectList = list.sublist(begin, widget.index + 1)
            : newSelectList = list
                  .sublist(widget.index, begin + 1)
                  .reversed
                  .toList();
        provider.clear();
        provider.addAll(newSelectList);
        SelectionState.menusUpdate(false);
      } else {
        SelectionState.menusUpdate(false);
        selectList.contains(menu) && selectList.length == 1
            ? provider.clear()
            : provider.one(menu);
      }
    }

    return Listener(
      onPointerDown: onPointerDown,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: Material(
          borderRadius: borderRadius,
          color: backgroundColor,
          child: InkWell(
            onTap: () {},
            onSecondaryTapDown: onSecondaryTapDown,
            borderRadius: borderRadius,
            mouseCursor: SystemMouseCursors.click,
            child: Container(
              height: AppNum.directiveHeight,
              padding: .only(
                left: AppNum.spaceMedium,
                right: AppNum.spaceSmall,
              ),
              decoration: BoxDecoration(borderRadius: borderRadius),
              child: Row(
                mainAxisSize: .max,
                crossAxisAlignment: .center,
                children: [
                  BaseText(widget.menu.type.label, color: color),
                  _spaceM,
                  buildInfo(),
                  _spaceM,
                  DynamicButton(
                    isHover: isHover,
                    icon: widget.menu.checked
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    onPressed: () {
                      provider.toggle(widget.menu);
                      advanceUpdateName(ref);
                    },
                  ),
                  _spaceS,
                  DynamicButton(
                    isHover: isHover,
                    icon: Icons.copy_all_rounded,
                    onPressed: () {
                      ref.read(currentPresetNameProvider.notifier).update('');
                      AdvanceMenuModel menu = widget.menu.copyWith(
                        id: generateId(),
                      );
                      provider.add(menu);
                      advanceUpdateName(ref);
                    },
                  ),
                  _spaceS,
                  DynamicButton(
                    isHover: isHover,
                    icon: Icons.edit_note_rounded,
                    onPressed: () {
                      switch (widget.menu.type) {
                        case AdvanceType.delete:
                          deleteText(context, widget.menu as AdvanceMenuDelete);
                          break;
                        case AdvanceType.add:
                          addText(context, widget.menu as AdvanceMenuAdd);
                          break;
                        case AdvanceType.replace:
                          replaceText(
                            context,
                            widget.menu as AdvanceMenuReplace,
                          );
                          break;
                      }
                    },
                  ),
                  ClickIcon(
                    icon: Icons.close_rounded,
                    size: 20,
                    iconSize: 16,
                    color: Colors.grey,
                    onPressed: () {
                      ref.read(currentPresetNameProvider.notifier).update('');
                      provider.remove(widget.menu);
                      advanceUpdateName(ref);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
