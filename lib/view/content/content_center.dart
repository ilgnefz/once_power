import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/list.dart';
import 'package:once_power/core/move.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';

import 'empty.dart';
import 'grid/grid.dart';
import 'list/list.dart';

final _viewProvider = Provider((ref) {
  List<FileInfo> files = ref.watch(sortListProvider);
  bool isViewMode = ref.watch(isViewModeProvider);
  FunctionMode mode = ref.watch(currentModeProvider);

  bool showView = isViewMode && !mode.isOrganize;

  if (files.isEmpty) return EmptyView(showImage: showView);
  if (ref.watch(toggleChangedProvider)) {
    bool onlyChanged = ref.watch(onlyChangedProvider);
    files = files.where((e) {
      return onlyChanged
          ? e.name != e.newName || e.extension != e.newExtension
          : e.name == e.newName && e.extension == e.newExtension;
    }).toList();
  }
  if (showView) return ContentGridView(files);
  return ContentListView(files);
});

class ContentCenter extends ConsumerWidget {
  const ContentCenter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = ref.watch(conetentFocusNodeProvider);

    return Focus(
      focusNode: focusNode,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          final LogicalKeyboardKey key = event.logicalKey;
          final Set<LogicalKeyboardKey> keysPressed =
              HardwareKeyboard.instance.logicalKeysPressed;
          final bool isControlPressed =
              keysPressed.contains(LogicalKeyboardKey.controlLeft) ||
              keysPressed.contains(LogicalKeyboardKey.controlRight);
          List<FileInfo> files = ref.read(sortListProvider);
          final List<FileInfo> selects = ref.read(sortSelectListProvider);
          final provider = ref.read(sortSelectListProvider.notifier);
          switch (key) {
            case LogicalKeyboardKey.delete:
              if (selects.isNotEmpty) {
                for (FileInfo file in selects) {
                  ref.read(fileListProvider.notifier).remove(file);
                }
                provider.clear();
              }
              break;
            case LogicalKeyboardKey.keyA when isControlPressed:
              final List<FileInfo> list = ref.read(sortListProvider);
              if (list.isNotEmpty) {
                provider.clear();
                provider.addAll(list);
              }
              break;
            case LogicalKeyboardKey.keyD when isControlPressed:
              provider.clear();
              break;
            case LogicalKeyboardKey.keyX when isControlPressed:
              suspenseFileList(ref, ref.watch(sortSelectListProvider));
              break;
            case LogicalKeyboardKey.keyC when isControlPressed:
              if (selects.isNotEmpty) toTheFront(ref, selects.last);
              break;
            case LogicalKeyboardKey.keyV when isControlPressed:
              if (selects.isNotEmpty) toTheBehind(ref, selects.last);
              break;
            case LogicalKeyboardKey.keyS when isControlPressed:
              toggleMultipleCheck(ref, selects);
              break;
            case LogicalKeyboardKey.arrowUp:
              if (selects.isEmpty) {
                provider.one(files.last);
              } else {
                FileInfo file = selects.last;
                int index = files.indexOf(file);
                index > 0
                    ? provider.one(files[index - 1])
                    : provider.one(files[files.length - 1]);
              }
              break;
            case LogicalKeyboardKey.arrowDown:
              if (selects.isEmpty) {
                provider.one(files.first);
              } else {
                FileInfo file = selects.last;
                int index = files.indexOf(file);
                index < files.length - 1
                    ? provider.one(files[index + 1])
                    : provider.one(files[0]);
              }
              break;
          }
        }
        return KeyEventResult.handled;
      },
      child: ref.watch(_viewProvider),
    );
  }
}
