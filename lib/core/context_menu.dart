import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/common/right_menu.dart';

Future<void> showRightMenu(
  BuildContext context,
  WidgetRef ref,
  Offset position,
  FileInfo file,
) async {
  final ThemeData theme = Theme.of(context);
  FunctionMode mode = ref.watch(currentModeProvider);
  bool onlyDateModify = ref.read(isDateModifyProvider);
  bool onlyNormal =
      (mode.isReplace || mode.isReserve) &&
      ref.read(cSVDataProvider).isEmpty &&
      !onlyDateModify;
  final entries = <ContextMenuEntry>[
    RightMenuItem(
      label: 'Copy',
      onSelected: (value) {
        // implement copy
      },
    ),
    RightMenuItem(
      enabled: false, // disable this item
      label: 'Cut',
      onSelected: (value) {
        // implement cut
      },
    ),
    RightMenuItem(
      label: 'Paste',
      onSelected: (value) {
        // implement paste
      },
    ),
    RightMenuItem.submenu(
      label: 'Edit',
      items: [
        RightMenuItem(
          label: 'Undo',
          value: "Undo",
          onSelected: (value) {
            // implement undo
          },
        ),
        RightMenuItem(
          label: 'Redo',
          value: 'Redo',
          onSelected: (value) {
            // implement redo
          },
        ),
      ],
    ),
  ];

  showContextMenu(
    context,
    contextMenu: ContextMenu(
      entries: entries,
      position: position,
      padding: .zero,
      maxWidth: 120,
      boxDecoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.black.withValues(alpha: .2)),
        ],
      ),
    ),
  );
}
