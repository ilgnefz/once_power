import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/models/advance.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/content/right_menu_item.dart';

import 'dialog.dart';
import 'input.dart';
import 'list.dart';
import 'move.dart';
import 'select.dart';

Future<void> showFileRightMenu(
  BuildContext context,
  WidgetRef ref,
  TapDownDetails details,
  FileInfo file, [
  bool isPreview = false,
]) async {
  final ThemeData theme = Theme.of(context);
  FunctionMode mode = ref.watch(currentModeProvider);
  bool show =
      (mode.isReplace || mode.isReserve) && ref.watch(cSVDataProvider).isEmpty;
  List<FileInfo> sortSelectList = [];
  sortSelectList = isPreview ? [file] : ref.watch(sortSelectListProvider);
  List<FileInfo> suspenseList = StorageUtil.getFileList(
    AppKeys.suspenseFileList,
  );
  await showContextMenu(
    context,
    contextMenu: ContextMenu(
      maxWidth: 120,
      boxDecoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.black.withValues(alpha: .2)),
        ],
      ),
      entries: <ContextMenuEntry>[
        RightMenuItem(
          label: tr(AppL10n.menuLocal),
          onSelected: () => openFileLocation(file.path),
        ),
        if (show)
          RightMenuItem(
            label: tr(AppL10n.menuMatch),
            onSelected: () => autoMatchInput(ref, file.name),
          ),
        if (show)
          RightMenuItem(
            label: tr(AppL10n.menuModify),
            onSelected: () => autoModifyInput(ref, file.name),
          ),
        RightMenuItem.submenu(
          label: tr(AppL10n.menuMove),
          items: [
            RightMenuItem(
              label: tr(AppL10n.menuFirst),
              onSelected: () => toTheFirst(ref, sortSelectList),
            ),
            RightMenuItem(
              label: tr(AppL10n.menuCenter),
              onSelected: () => toTheCenter(ref, sortSelectList),
            ),
            RightMenuItem(
              label: tr(AppL10n.menuLast),
              onSelected: () => toTheLast(ref, sortSelectList),
            ),
          ],
        ),
        if (suspenseList.isEmpty && !isPreview)
          RightMenuItem(
            label: tr(AppL10n.menuSuspense),
            onSelected: () => suspenseFileList(ref, sortSelectList),
          ),
        if (suspenseList.isNotEmpty && !isPreview)
          RightMenuItem.submenu(
            label: tr(AppL10n.menuTakeout),
            color: Theme.of(context).primaryColor,
            items: [
              RightMenuItem(
                label: tr(AppL10n.menuFront),
                onSelected: () => toTheFront(ref, file),
              ),
              RightMenuItem(
                label: tr(AppL10n.menuBehind),
                onSelected: () => toTheBehind(ref, file),
              ),
            ],
          ),
        if (mode.isOrganize)
          RightMenuItem(
            label: tr(AppL10n.menuPath),
            onSelected: () => ref
                .read(folderControllerProvider.notifier)
                .updateText(file.parent),
          ),
        if (mode.isAdvance || mode.isOrganize)
          RightMenuItem.submenu(
            label: tr(AppL10n.menuGroup),
            items: [
              RightMenuItem(
                label: tr(AppL10n.menuEdit),
                color: Theme.of(context).primaryColor,
                onSelected: () => editGroup(context),
              ),
              ...buildGroupList(context, ref, file),
            ],
          ),
        RightMenuItem(
          label:
              file.checked ? tr(AppL10n.menuUnselect) : tr(AppL10n.menuSelect),
          color: file.checked ? Colors.grey : theme.colorScheme.surfaceDim,
          onSelected: () => toggleMultipleCheck(ref, sortSelectList),
        ),
        if (mode.isAdvance || mode.isOrganize)
          RightMenuItem(
            label: tr(AppL10n.menuSelectGroup),
            onSelected: () => selectGroup(ref, file.group),
          ),
        RightMenuItem(
          label: tr(AppL10n.menuSelectPath),
          onSelected: () => selectPath(ref, file.parent),
        ),
        if (!isPreview)
          RightMenuItem(
            label: tr(AppL10n.menuRemoveFolder),
            color: Colors.red,
            onSelected: () => removeFolder(ref, sortSelectList),
          ),
        if (!isPreview)
          RightMenuItem(
            label: tr(AppL10n.menuRemove),
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
  List<String> list = StorageUtil.getStringList(AppKeys.groupList);
  return list
      .map(
        (e) => RightMenuItem.submenu(
          label: e,
          color: file.group == e
              ? Theme.of(context).textTheme.bodyMedium?.color
              : Colors.grey,
          onSelected: () => setGroup(context, ref, e),
          items: [
            RightMenuItem(
              label: tr(AppL10n.menuRemove),
              color: Colors.red,
              onSelected: () async => await removeGroup(ref, e),
            ),
          ],
        ),
      )
      .toList();
}

Future<void> showDirectiveRightMenu(
  BuildContext context,
  WidgetRef ref,
  TapDownDetails details,
) async {
  List<AdvanceMenuModel> list = ref.watch(advanceMenuSelectedListProvider);
  ThemeData theme = Theme.of(context);
  await showContextMenu(
    context,
    contextMenu: ContextMenu(
      maxWidth: 120,
      boxDecoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.black.withValues(alpha: .2)),
        ],
      ),
      entries: <ContextMenuEntry>[
        RightMenuItem(
          label: tr(AppL10n.menuToggle),
          onSelected: () {
            for (var element in list) {
              ref.read(advanceMenuListProvider.notifier).toggle(element);
            }
            ref.read(advanceMenuSelectedListProvider.notifier).clear();
            advanceUpdateName(ref);
          },
        ),
        RightMenuItem.submenu(
          label: tr(AppL10n.menuEdit),
          items: [
            RightMenuItem(
              label: tr(AppL10n.menuEdit),
              color: Theme.of(context).primaryColor,
              onSelected: () => editGroup(context, true),
            ),
            ...buildDirectiveGroupList(context, ref, list),
          ],
        ),
        RightMenuItem(
          label: tr(AppL10n.menuRemove),
          onSelected: () {
            for (var element in list) {
              ref.read(advanceMenuListProvider.notifier).remove(element);
            }
            ref.read(currentPresetNameProvider.notifier).update('');
            advanceUpdateName(ref);
          },
        ),
        RightMenuItem(
          label: tr(AppL10n.menuCancel),
          onSelected: () {
            ref.read(advanceMenuSelectedListProvider.notifier).clear();
            advanceUpdateName(ref);
          },
        ),
      ],
      padding: EdgeInsets.zero,
      position: details.globalPosition,
      // maxWidth: 120,
    ),
  );
}

List<ContextMenuEntry> buildDirectiveGroupList(
  BuildContext context,
  WidgetRef ref,
  List<AdvanceMenuModel> menuList,
) {
  List<String> list = ['all'];
  list.addAll(StorageUtil.getStringList(AppKeys.groupList));
  return list
      .map(
        (e) => RightMenuItem(
          label: e == 'all' ? tr(AppL10n.dialogAll) : e,
          color: Theme.of(context).textTheme.bodyMedium?.color,
          onSelected: () {
            for (var element in menuList) {
              ref
                  .read(advanceMenuListProvider.notifier)
                  .setGroup(element.id, e);
            }
            ref.read(advanceMenuSelectedListProvider.notifier).clear();
            advanceUpdateName(ref);
          },
        ),
      )
      .toList();
}
