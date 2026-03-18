import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/context_menu.dart';
import 'package:once_power/config/theme/dropdown.dart';
import 'package:once_power/const/input.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/util/selection.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/widget/common/right_menu.dart';

import 'dialog.dart';
import 'list.dart';
import 'move.dart';
import 'select.dart';
import 'update/advance.dart';

Future<void> showRightMenu(
  BuildContext context,
  WidgetRef ref,
  Offset position,
  FileInfo file, [
  bool isPreview = false,
]) async {
  final ThemeData theme = Theme.of(context);
  FunctionMode mode = ref.watch(currentModeProvider);
  bool onlyDateModify = ref.read(isDateModifyProvider);
  bool onlyCSV = ref.read(cSVDataProvider).isNotEmpty;
  bool onlyFunctionMode = !(onlyCSV || onlyDateModify);
  bool onlyNormal = (mode.isReplace || mode.isReserve) && onlyFunctionMode;
  List<FileInfo> sortSelectList = [];
  sortSelectList = isPreview ? [file] : ref.read(sortSelectListProvider);
  if (!sortSelectList.contains(file)) {
    sortSelectList.clear();
    sortSelectList.add(file);
  }
  List<FileInfo> suspenseList = SuspenseState.list;
  final List<ContextMenuEntry> entries = <ContextMenuEntry>[
    RightMenuItem(
      label: tr(AppL10n.menuLocal),
      onSelected: (_) => openFileLocation(file.path),
    ),
    if (onlyNormal) ...[
      RightMenuItem(
        label: tr(AppL10n.menuMatch),
        onSelected: (_) => autoMatchInput(ref, file.name),
      ),
      RightMenuItem(
        label: tr(AppL10n.menuModify),
        onSelected: (_) => autoModifyInput(ref, file.name),
      ),
    ],
    if (onlyDateModify)
      RightMenuItem.submenu(
        label: tr(AppL10n.menuDate),
        items: [
          RightMenuItem(
            label: tr(AppL10n.menuAll),
            onSelected: (_) => autoMatchDateInput(ref, file),
          ),
          RightMenuItem(
            label: tr(AppL10n.eDateCreate),
            onSelected: (_) => autoMatchCreateInput(ref, file),
          ),
          RightMenuItem(
            label: tr(AppL10n.eDateModify),
            onSelected: (_) => autoMatchModifyInput(ref, file),
          ),
          RightMenuItem(
            label: tr(AppL10n.eDateAccess),
            onSelected: (_) => autoMatchAccessInput(ref, file),
          ),
        ],
      ),
    RightMenuItem.submenu(
      label: tr(AppL10n.menuMove),
      items: [
        RightMenuItem(
          label: tr(AppL10n.menuFirst),
          onSelected: (_) => toTheFirst(ref, sortSelectList),
        ),
        RightMenuItem(
          label: tr(AppL10n.menuCenter),
          onSelected: (_) => toTheCenter(ref, sortSelectList),
        ),
        RightMenuItem(
          label: tr(AppL10n.menuLast),
          onSelected: (_) => toTheLast(ref, sortSelectList),
        ),
      ],
    ),
    if (suspenseList.isEmpty && !isPreview)
      RightMenuItem(
        label: tr(AppL10n.menuSuspense),
        onSelected: (_) => suspenseFileList(ref, sortSelectList),
      ),
    if (suspenseList.isNotEmpty && !isPreview)
      RightMenuItem.submenu(
        label: tr(AppL10n.menuTakeout),
        color: Theme.of(context).primaryColor,
        items: [
          RightMenuItem(
            label: tr(AppL10n.menuFront),
            onSelected: (_) => toTheFront(ref, file),
          ),
          RightMenuItem(
            label: tr(AppL10n.menuBehind),
            onSelected: (_) => toTheBehind(ref, file),
          ),
        ],
      ),
    if (mode.isOrganize && onlyFunctionMode)
      RightMenuItem(
        label: tr(AppL10n.menuPath),
        onSelected: (_) =>
            ref.read(folderControllerProvider.notifier).update(file.parent),
      ),
    if (mode.isAdvance || mode.isOrganize && onlyFunctionMode)
      RightMenuItem.submenu(
        label: tr(AppL10n.menuGroup),
        items: [
          RightMenuItem(
            label: tr(AppL10n.menuEdit),
            color: Theme.of(context).primaryColor,
            onSelected: (_) => editGroup(context, false, file),
          ),
          RightMenuItem(
            label: tr(AppL10n.menuAutoGroup),
            color: Theme.of(context).primaryColor,
            onSelected: (_) => autoGroup(context, file),
          ),
          ...buildGroupList(context, ref, file),
        ],
      ),
    RightMenuItem(
      label: file.checked ? tr(AppL10n.menuUnselect) : tr(AppL10n.menuSelect),
      color: file.checked ? Colors.grey : theme.textTheme.bodyMedium?.color,
      onSelected: (_) =>
          toggleMultipleCheck(ref, sortSelectList, !file.checked),
    ),
    if (mode.isAdvance || mode.isOrganize && onlyFunctionMode)
      RightMenuItem(
        label: tr(AppL10n.menuSelectGroup),
        onSelected: (_) => selectGroup(ref, file.group),
      ),
    RightMenuItem(
      label: tr(AppL10n.menuSelectType),
      onSelected: (_) => selectType(ref, file.type),
    ),
    RightMenuItem(
      label: tr(AppL10n.menuSelectPath),
      onSelected: (_) => selectPath(ref, file.parent),
    ),
    if (!isPreview)
      RightMenuItem(
        label: tr(AppL10n.menuRemoveFolder),
        color: Colors.red,
        onSelected: (_) => removeFolder(ref, sortSelectList),
      ),
    if (!isPreview)
      RightMenuItem(
        label: tr(AppL10n.menuRemove),
        color: Colors.red,
        onSelected: (_) => removeMultiple(ref, sortSelectList),
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
        color: theme.extension<ContextMenuTheme>()?.backgroundColor,
        borderRadius: .circular(AppNum.radius),
        boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.black.withValues(alpha: .2)),
        ],
      ),
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
          onSelected: (_) => setGroup(context, ref, e, file),
          items: <ContextMenuEntry>[
            RightMenuItem(
              label: tr(AppL10n.menuRemove),
              color: Colors.red,
              onSelected: (_) async => await removeGroup(ref, e),
            ),
          ],
        ),
      )
      .toList();
}

Future<void> showDirectiveRightMenu(
  BuildContext context,
  WidgetRef ref,
  Offset position,
  AdvanceMenuModel menu,
) async {
  List<AdvanceMenuModel> list = ref.watch(advanceMenuSelectedListProvider);
  if (!list.contains(menu)) {
    list.clear();
    list.add(menu);
  }
  ThemeData theme = Theme.of(context);
  final List<ContextMenuEntry> entries = <ContextMenuEntry>[
    RightMenuItem(
      label: tr(AppL10n.menuToggle),
      onSelected: (_) {
        for (var element in list) {
          ref.read(advanceMenuListProvider.notifier).toggle(element);
        }
        ref.read(advanceMenuSelectedListProvider.notifier).clear();
        advanceUpdateName(ref);
      },
    ),
    RightMenuItem.submenu(
      label: tr(AppL10n.menuEdit),
      items: <ContextMenuEntry>[
        RightMenuItem(
          label: tr(AppL10n.menuEdit),
          color: Theme.of(context).primaryColor,
          onSelected: (_) => editGroup(context, true),
        ),
        ...buildDirectiveGroupList(context, ref, list, menu),
      ],
    ),
    RightMenuItem(
      label: tr(AppL10n.menuRemove),
      onSelected: (_) {
        for (var element in list) {
          ref.read(advanceMenuListProvider.notifier).remove(element);
        }
        ref.read(currentPresetNameProvider.notifier).update('');
        advanceUpdateName(ref);
      },
    ),
    RightMenuItem(
      label: tr(AppL10n.menuCancel),
      onSelected: (_) {
        ref.read(advanceMenuSelectedListProvider.notifier).clear();
        advanceUpdateName(ref);
      },
    ),
  ];
  await showContextMenu(
    context,
    contextMenu: ContextMenu(
      maxWidth: 120,
      boxDecoration: BoxDecoration(
        color: theme.extension<ContextMenuTheme>()?.backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(blurRadius: 2, color: Colors.black.withValues(alpha: .2)),
        ],
      ),
      entries: entries,
      padding: EdgeInsets.zero,
      position: position,
      // maxWidth: 120,
    ),
  );
}

List<ContextMenuEntry> buildDirectiveGroupList(
  BuildContext context,
  WidgetRef ref,
  List<AdvanceMenuModel> menuList,
  AdvanceMenuModel menu,
) {
  List<String> list = ['all'];
  list.addAll(StorageUtil.getStringList(AppKeys.groupList));
  return list
      .map(
        (e) => RightMenuItem(
          label: e == 'all' ? tr(AppL10n.dialogAll) : e,
          color: menu.group == e
              ? Theme.of(context).textTheme.bodyMedium?.color
              : Colors.grey,
          onSelected: (_) {
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
