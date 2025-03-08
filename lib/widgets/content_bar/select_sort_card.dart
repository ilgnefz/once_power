import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/menu.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/list.dart';

import 'rename_tile_tooltip.dart';

class SelectSortCard extends ConsumerWidget {
  const SelectSortCard({
    super.key,
    required this.index,
    required this.file,
    required this.child,
    this.onDoubleTap,
  });

  // final List<FileInfo> files;
  final int index;
  final FileInfo file;
  final Widget child;
  final void Function()? onDoubleTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<FileInfo> sortSelectList = ref.watch(sortSelectListProvider);
    BorderRadius borderRadius = BorderRadius.circular(4);
    Color selectedColor = Theme.of(context).primaryColor.withValues(alpha: .1);
    Color bgColor =
        sortSelectList.contains(file) ? selectedColor : Colors.transparent;
    String? indexLabel =
        sortSelectList.contains(file) && sortSelectList.length > 1
            ? '${sortSelectList.indexOf(file) + 1}'
            : null;

    void onPointerDown(PointerDownEvent event) {
      if (event.buttons == kPrimaryButton &&
          event.localPosition != Offset.zero) {
        Set keysPressed = HardwareKeyboard.instance.logicalKeysPressed;
        final isCtrlPressed =
            keysPressed.contains(LogicalKeyboardKey.controlLeft) ||
                keysPressed.contains(LogicalKeyboardKey.controlRight);
        final isShiftPressed =
            keysPressed.contains(LogicalKeyboardKey.shiftLeft) ||
                keysPressed.contains(LogicalKeyboardKey.shiftRight);
        if (isCtrlPressed) {
          // debugPrint('检测到Ctrl + 左键点击！');
          if (sortSelectList.contains(file)) {
            ref.read(sortSelectListProvider.notifier).remove(file);
          } else {
            ref.read(sortSelectListProvider.notifier).add(file);
          }
        } else if (isShiftPressed) {
          List<FileInfo> sortList = ref.read(sortListProvider);
          int beginIndex = 0;
          // int endIndex = files.indexOf(file);
          if (sortSelectList.isNotEmpty) {
            beginIndex = sortList.indexOf(sortSelectList.first);
          }
          List<FileInfo> newSelectList = [];
          if (beginIndex < index) {
            newSelectList.addAll(sortList.sublist(beginIndex, index + 1));
          } else {
            newSelectList
                .addAll(sortList.sublist(index, beginIndex + 1).reversed);
          }
          ref.read(sortSelectListProvider.notifier).clear();
          ref.read(sortSelectListProvider.notifier).addAll(newSelectList);
        } else {
          if (sortSelectList.contains(file) && sortSelectList.length == 1) {
            ref.read(sortSelectListProvider.notifier).clear();
          } else {
            ref.read(sortSelectListProvider.notifier).one(file);
          }
        }
      }
    }

    void onHover(bool hover) {
      if (hover) {
        bgColor = selectedColor;
        ref.read(sortHoverFileProvider.notifier).update(file);
      } else {
        if (!sortSelectList.contains(file)) {
          bgColor = Colors.transparent;
          ref.read(sortHoverFileProvider.notifier).update(null);
        }
      }
    }

    Future<void> onSecondaryTapDown(TapDownDetails details) async {
      bgColor = selectedColor;
      if (!sortSelectList.contains(file)) {
        ref.read(sortHoverFileProvider.notifier).update(file);
      }
      FileInfo? hoverFile = ref.watch(sortHoverFileProvider);
      if (hoverFile != null && !sortSelectList.contains(hoverFile)) {
        ref.read(sortSelectListProvider.notifier).one(hoverFile);
      }
      await showRightMenu(context, ref, details, file);
    }

    return RenameTileTooltip(
      file: file,
      waitDuration: const Duration(seconds: 2),
      child: Listener(
        onPointerDown: onPointerDown,
        child: Material(
          borderRadius: borderRadius,
          color: bgColor,
          child: Stack(
            children: [
              InkWell(
                borderRadius: borderRadius,
                onDoubleTap: onDoubleTap,
                onHover: onHover,
                onSecondaryTapDown: onSecondaryTapDown,
                hoverColor: selectedColor,
                focusColor: selectedColor,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: child,
              ),
              if (indexLabel != null)
                Badge(
                  alignment: Alignment.topRight,
                  // isLabelVisible: file.checked,
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(indexLabel),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
