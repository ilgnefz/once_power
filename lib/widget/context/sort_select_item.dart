import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/theme.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/context_menu.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/util/selection.dart';
import 'package:once_power/widget/context/tooltip_item.dart';

class SortSelectItem extends ConsumerWidget {
  const SortSelectItem({
    super.key,
    required this.index,
    required this.file,
    this.onTap,
    this.onDoubleTap,
    required this.child,
  });

  final int index;
  final FileInfo file;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<FileInfo> selectList = ref.watch(sortSelectListProvider);
    BorderRadius borderRadius = BorderRadius.circular(4);
    // TODO: 深色模式下看不清
    Color? backgroundColor = selectList.contains(file)
        ? Theme.of(context).hoverColor
        : null;
    String? indexLabel = selectList.contains(file) && selectList.length > 1
        ? '${selectList.indexOf(file) + 1}'
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
      final SortSelectList provider = ref.read(sortSelectListProvider.notifier);
      if (isCtrlPressed) {
        SelectionState.filesUpdate(true);
        selectList.contains(file) ? provider.remove(file) : provider.add(file);
      } else if (isShiftPressed) {
        List<FileInfo> list = ref.read(sortListProvider);
        int begin = 0;
        if (selectList.isNotEmpty) {
          FileInfo startFile = SelectionState.filesPressedCtrl
              ? selectList.last
              : selectList.first;
          begin = list.indexOf(startFile);
        }
        List<FileInfo> newSelectList = [];
        begin < index
            ? newSelectList = list.sublist(begin, index + 1)
            : newSelectList = list.sublist(index, begin + 1).reversed.toList();
        provider.clear();
        provider.addAll(newSelectList);
        SelectionState.filesUpdate(false);
      } else {
        SelectionState.filesUpdate(false);
        selectList.contains(file) && selectList.length == 1
            ? provider.clear()
            : provider.one(file);
      }
    }

    Future<void> onSecondaryTapDown(TapDownDetails details) async {
      await showRightMenu(context, ref, details.globalPosition, file);
    }

    return TooltipItem(
      file: file,
      child: Listener(
        onPointerDown: onPointerDown,
        child: Material(
          borderRadius: borderRadius,
          color: backgroundColor,
          child: Stack(
            children: [
              InkWell(
                mouseCursor: SystemMouseCursors.click,
                borderRadius: BorderRadius.circular(AppNum.radius),
                onTap: () {
                  onTap?.call();
                  ref.read(conetentFocusNodeProvider).requestFocus();
                },
                onDoubleTap: onDoubleTap,
                onSecondaryTapDown: onSecondaryTapDown,
                child: child,
              ),
              if (indexLabel != null)
                Badge(
                  alignment: Alignment.topRight,
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(
                    indexLabel,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontFamily: defaultFont,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
