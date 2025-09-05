import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/upload.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/views/content/empty.dart';
import 'package:once_power/views/content/grid/content.dart';
import 'package:once_power/views/content/top/top.dart';

import 'list/content.dart';

class ContentView extends StatefulWidget {
  const ContentView({super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
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
      // 示例：处理Delete键删除选中文件
      if (event.logicalKey == LogicalKeyboardKey.delete) {
        debugPrint('Delete key pressed');
      }

      Set<LogicalKeyboardKey> keysPressed =
          HardwareKeyboard.instance.logicalKeysPressed;

      bool isControlPressed =
          keysPressed.contains(LogicalKeyboardKey.controlLeft) ||
          keysPressed.contains(LogicalKeyboardKey.controlRight);

      // 示例：处理Ctrl+A全选
      if (event.logicalKey == LogicalKeyboardKey.keyA && isControlPressed) {
        debugPrint('Ctrl+A pressed - Select all');
      }

      // 示例：处理Ctrl+F搜索
      if (event.logicalKey == LogicalKeyboardKey.keyF && isControlPressed) {
        debugPrint('Ctrl+F pressed - Search');
      }
    }
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Focus(
        focusNode: _focusNode,
        onKeyEvent: _handleKeyEvent,
        child: Listener(
          onPointerDown: (_) => _focusNode.requestFocus(),
          child: Column(
            children: [
              ContentTop(),
              Expanded(
                child: Consumer(
                  builder: (_, ref, _) => DropTarget(
                    onDragDone: (details) => dropFile(details, ref),
                    child: Builder(
                      builder: (_) {
                        List<FileInfo> files = ref.watch(sortListProvider);
                        if (files.isEmpty) return EmptyView();
                        bool isViewMode = ref.watch(isViewModeProvider);
                        if (isViewMode) return ContentGrid(files: files);
                        return ContentList(files: files);
                      },
                    ),
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
