import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/cores/context_menu.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/content/tooltip_item.dart';

class SelectSortItem extends ConsumerWidget {
  const SelectSortItem({
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
    Color bgColor = sortSelectList.contains(file)
        ? selectedColor
        : Colors.transparent;
    String? indexLabel =
        sortSelectList.contains(file) && sortSelectList.length > 1
        ? '${sortSelectList.indexOf(file) + 1}'
        : null;

    // 处理鼠标按下事件的回调函数
    void onPointerDown(PointerDownEvent event) async {
      // 仅处理鼠标左键按下且点击位置非零点的情况
      if (event.buttons == kPrimaryButton &&
          event.localPosition != Offset.zero) {
        // 获取当前按下的键盘按键集合
        Set keysPressed = HardwareKeyboard.instance.logicalKeysPressed;
        // 判断Ctrl键是否被按下（左右Ctrl均可）
        bool isCtrlPressed =
            keysPressed.contains(LogicalKeyboardKey.controlLeft) ||
            keysPressed.contains(LogicalKeyboardKey.controlRight);
        // 判断Shift键是否被按下（左右Shift均可）
        bool isShiftPressed =
            keysPressed.contains(LogicalKeyboardKey.shiftLeft) ||
            keysPressed.contains(LogicalKeyboardKey.shiftRight);

        if (isCtrlPressed) {
          await StorageUtil.setBool(AppKeys.hadPressedCtrl, true);
          // Ctrl键按下时：切换当前文件的选中状态（选中则取消，未选中则添加）
          // debugPrint('检测到Ctrl + 左键点击！');
          if (sortSelectList.contains(file)) {
            // 若已选中，从选中列表中移除当前文件
            ref.read(sortSelectListProvider.notifier).remove(file);
          } else {
            // 若未选中，将当前文件添加到选中列表
            ref.read(sortSelectListProvider.notifier).add(file);
          }
        } else if (isShiftPressed) {
          // Shift键按下时：按顺序选中从首个已选文件到当前文件的连续区间
          List<FileInfo> sortList = ref.read(sortListProvider);
          int beginIndex = 0; // 起始索引（默认从0开始）
          // int endIndex = files.indexOf(file);
          // 若已有选中文件，起始索引为首个已选文件在排序列表中的位置
          if (sortSelectList.isNotEmpty) {
            FileInfo startFile = StorageUtil.getBool(AppKeys.hadPressedCtrl)
                ? sortSelectList.last
                : sortSelectList.first;
            beginIndex = sortList.indexOf(startFile);
          }
          List<FileInfo> newSelectList = [];
          // 根据起始索引与当前文件索引的关系，生成连续选中区间
          if (beginIndex < index) {
            // 起始索引小于当前索引时，选中[beginIndex, index]区间
            newSelectList.addAll(sortList.sublist(beginIndex, index + 1));
          } else {
            // 起始索引大于当前索引时，反向选中[index, beginIndex]区间
            newSelectList.addAll(
              sortList.sublist(index, beginIndex + 1).reversed,
            );
          }
          // 清空原选中列表并添加新的连续选中区间
          await StorageUtil.setBool(AppKeys.hadPressedCtrl, false);
          ref.read(sortSelectListProvider.notifier).clear();
          ref.read(sortSelectListProvider.notifier).addAll(newSelectList);
        } else {
          // 无修饰键按下时：单选逻辑（若当前文件已选中且仅选中一个，则清空；否则单选当前文件）
          if (sortSelectList.contains(file) && sortSelectList.length == 1) {
            ref.read(sortSelectListProvider.notifier).clear();
          } else {
            ref.read(sortSelectListProvider.notifier).one(file);
          }
          await StorageUtil.setBool(AppKeys.hadPressedCtrl, false);
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
      await showFileRightMenu(context, ref, details, file);
    }

    return TooltipItem(
      file: file,
      waitDuration: const Duration(seconds: 1),
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
