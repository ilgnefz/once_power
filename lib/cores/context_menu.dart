import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/cores/sort.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/content_bar/right_menu_item.dart';

import 'dialog.dart';
import 'input.dart';
import 'list.dart';

Future<void> showRightMenu(
  BuildContext context,
  WidgetRef ref,
  TapDownDetails details,
  FileInfo file, [
  bool isPreview = false,
]) async {
  // const double safeW = 16, safeH = 32;
  // Locale? loe = StorageUtil.getLocale(AppKeys.locale);
  FunctionMode mode = ref.watch(currentModeProvider);
  bool show =
      (mode.isReplace || mode.isReserve) && ref.watch(cSVDataProvider).isEmpty;
  // int count = show ? 9 : 7;
  // if (mode.isOrganize) count = 8;
  // double width = loe?.languageCode != 'zh' ? 120 : 80;
  List<FileInfo> sortSelectList = [];
  sortSelectList = isPreview ? [file] : ref.watch(sortSelectListProvider);
  final theme = Theme.of(context);
  await showContextMenu(
    context,
    contextMenu: ContextMenu(
      maxWidth: 120,
      boxDecoration: BoxDecoration(
        color: theme.colorScheme.onSurface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.black.withValues(alpha: .2),
          ),
        ],
      ),
      entries: <ContextMenuEntry>[
        RightMenuItem(
          label: S.of(context).openPosition,
          onSelected: () => openFileLocation(file.filePath),
        ),
        if (show)
          RightMenuItem(
            label: S.of(context).matchName,
            onSelected: () => autoMatchInput(ref, file.name),
          ),
        if (show)
          RightMenuItem(
            label: S.of(context).modifyName,
            onSelected: () => autoModifyInput(ref, file.name),
          ),
        RightMenuItem.submenu(
          label: S.of(context).move,
          items: [
            RightMenuItem(
              label: S.of(context).moveToFirst,
              onSelected: () => toTheFirst(ref, sortSelectList),
            ),
            RightMenuItem(
              label: S.of(context).moveToCenter,
              onSelected: () => toTheCenter(ref, sortSelectList),
            ),
            RightMenuItem(
              label: S.of(context).moveToLast,
              onSelected: () => toTheLast(ref, sortSelectList),
            ),
          ],
        ),
        if (StorageUtil.getFileList(AppKeys.suspenseFileList).isEmpty)
          RightMenuItem(
            label: S.of(context).suspenseFile,
            onSelected: () => suspenseFileList(ref, sortSelectList),
          ),
        if (StorageUtil.getFileList(AppKeys.suspenseFileList).isNotEmpty)
          RightMenuItem.submenu(
            label: S.of(context).takeOut,
            color: Theme.of(context).primaryColor,
            items: [
              RightMenuItem(
                label: S.of(context).toFront,
                onSelected: () => toTheFront(ref, file),
              ),
              RightMenuItem(
                label: S.of(context).toBehind,
                onSelected: () => toTheBehind(ref, file),
              ),
            ],
          ),
        if (mode.isOrganize)
          RightMenuItem(
            label: S.of(context).matchParent,
            onSelected: () => ref
                .read(folderControllerProvider.notifier)
                .updateText(file.parent),
          ),
        if (mode.isAdvance || mode.isOrganize)
          RightMenuItem.submenu(
            label: S.of(context).settingGroup,
            items: [
              RightMenuItem(
                label: S.of(context).editGroup,
                color: Theme.of(context).primaryColor,
                // onSelected: () async => await editGroup(ref, file.name),
                onSelected: () => editGroup(context),
              ),
              ...buildGroupList(context, ref, file),
            ],
          ),
        RightMenuItem(
          label: file.checked ? S.of(context).unselect : S.of(context).select,
          color: file.checked ? Colors.grey : theme.colorScheme.surfaceDim,
          onSelected: () => toggleMultipleCheck(ref, sortSelectList),
        ),
        if (mode.isAdvance || mode.isOrganize)
          RightMenuItem(
            label: S.of(context).selectGroup,
            onSelected: () => selectGroup(ref, file.group),
          ),
        RightMenuItem(
          label: S.of(context).selectPath,
          onSelected: () => selectPath(ref, file.parent),
        ),
        if (!isPreview)
          RightMenuItem(
            label: S.of(context).removeFolder,
            color: Colors.red,
            onSelected: () => removeFolder(ref, sortSelectList),
          ),
        if (!isPreview)
          RightMenuItem(
            label: S.of(context).remove,
            color: Colors.red,
            onSelected: () => removeMultiple(ref, sortSelectList),
          ),
      ],
      padding: EdgeInsets.zero,
      position: details.globalPosition,
      // maxWidth: 120,
    ),
  );
}

List<ContextMenuEntry> buildGroupList(
  BuildContext context,
  WidgetRef ref,
  FileInfo file,
) {
  // List<String> list = ref.watch(groupListProvider);
  List<String> list = StorageUtil.getStringList(AppKeys.groupList);
  return list
      .map((e) => RightMenuItem.submenu(
            label: e,
            color: file.group == e
                ? Theme.of(context).colorScheme.surfaceDim
                : Colors.grey,
            onSelected: () => setGroup(context, ref, e),
            items: [
              RightMenuItem(
                label: S.of(context).remove,
                color: Colors.red,
                onSelected: () async => await removeGroup(ref, e),
              ),
            ],
          ))
      .toList();
}
