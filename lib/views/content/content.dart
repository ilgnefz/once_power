import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/cores/move.dart';
import 'package:once_power/cores/upload.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/models/progress.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/views/content/empty.dart';
import 'package:once_power/views/content/grid/content.dart';
import 'package:once_power/views/content/top/top.dart';

import 'list/content.dart';
import 'progress.dart';

final _viewProvider = Provider((ref) {
  List<FileInfo> files = ref.watch(sortListProvider);
  if (files.isEmpty) return EmptyView();
  bool isViewMode = ref.watch(isViewModeProvider);
  FunctionMode mode = ref.watch(currentModeProvider);
  if (isViewMode && !mode.isOrganize) return ContentGrid(files: files);
  return ContentList(files: files);
});

class ContentView extends ConsumerStatefulWidget {
  const ContentView({super.key});

  @override
  ConsumerState<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends ConsumerState<ContentView> {
  // 用于接收键盘事件的焦点节点
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 请求焦点，确保组件能够接收键盘事件
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    // 释放焦点节点
    _focusNode.dispose();
    super.dispose();
  }

  // 处理键盘事件的方法
  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      Set<LogicalKeyboardKey> keysPressed =
          HardwareKeyboard.instance.logicalKeysPressed;

      bool isControlPressed =
          keysPressed.contains(LogicalKeyboardKey.controlLeft) ||
          keysPressed.contains(LogicalKeyboardKey.controlRight);

      List<FileInfo> files = ref.watch(sortSelectListProvider);

      if (event.logicalKey == LogicalKeyboardKey.delete) {
        if (files.isNotEmpty) {
          for (FileInfo file in files) {
            ref.read(fileListProvider.notifier).remove(file);
          }
          ref.read(sortSelectListProvider.notifier).clear();
        }
      }

      if (event.logicalKey == LogicalKeyboardKey.keyA && isControlPressed) {
        List<FileInfo> list = ref.read(sortListProvider);
        if (list.isNotEmpty) {
          ref.read(sortSelectListProvider.notifier).clear();
          ref.read(sortSelectListProvider.notifier).addAll(list);
        }
      }

      if (event.logicalKey == LogicalKeyboardKey.keyX && isControlPressed) {
        suspenseFileList(ref, ref.watch(sortSelectListProvider));
      }

      if (event.logicalKey == LogicalKeyboardKey.keyC && isControlPressed) {
        if (files.isNotEmpty) toTheFront(ref, files.last);
      }
      if (event.logicalKey == LogicalKeyboardKey.keyV && isControlPressed) {
        if (files.isNotEmpty) toTheBehind(ref, files.last);
      }
      if (event.logicalKey == LogicalKeyboardKey.keyS && isControlPressed) {
        toggleMultipleCheck(ref, files);
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        if (files.isNotEmpty) {
          FileInfo file = files.last;
          int index = ref.read(sortListProvider).indexOf(file);
          if (index > 0) {
            FileInfo newFile = ref.read(sortListProvider)[index - 1];
            ref.read(sortSelectListProvider.notifier).clear();
            ref.read(sortSelectListProvider.notifier).add(newFile);
          }
        }
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        if (files.isNotEmpty) {
          FileInfo file = files.last;
          int index = ref.read(sortListProvider).indexOf(file);
          if (index < ref.read(sortListProvider).length - 1) {
            FileInfo newFile = ref.read(sortListProvider)[index + 1];
            ref.read(sortSelectListProvider.notifier).clear();
            ref.read(sortSelectListProvider.notifier).add(newFile);
          }
        }
      }
    }
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AbsorbPointer(
        absorbing: ref.watch(isApplyingProvider),
        child: Focus(
          focusNode: _focusNode,
          onKeyEvent: _handleKeyEvent,
          child: Listener(
            onPointerDown: (_) => _focusNode.requestFocus(),
            child: Builder(
              builder: (context) {
                ProgressFileInfo? info = ref.watch(currentProgressFileProvider);
                bool than = getAllSize(ref) > AppNum.maxFileSize;
                if (info != null && than) return ProgressView(info: info);
                return Column(
                  children: [
                    ContentTop(),
                    Expanded(
                      child: DropTarget(
                        onDragDone: (details) => dropFile(details, ref),
                        child: ref.watch(_viewProvider),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
