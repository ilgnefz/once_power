import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:tray_manager/tray_manager.dart';

import 'core.dart';

void unselectDateName(WidgetRef ref) {
  if (ref.watch(dateRenameProvider)) {
    ref.read(dateRenameProvider.notifier).update();
  }
}

void autoMatchInput(WidgetRef ref, String name) {
  if (ref.watch(currentModeProvider) == FunctionMode.reserve) {
    ref.read(modifyControllerProvider).clear();
    unselectDateName(ref);
  }
  ref.read(matchControllerProvider.notifier).updateText(name);
  updateName(ref);
}

void autoModifyInput(WidgetRef ref, String name) {
  if (ref.watch(currentModeProvider) == FunctionMode.reserve) {
    ref.read(matchControllerProvider).clear();
  }
  unselectDateName(ref);
  ref.read(modifyControllerProvider.notifier).updateText(name);
  updateName(ref);
}

void toTheFirst(WidgetRef ref, FileInfo file) {
  List<FileInfo> files = ref.watch(sortListProvider);
  int index = files.indexWhere((e) => e == file);
  if (index == 0) return;
  deleteOne(ref, file.id);
  insertFirst(ref, file);
  ref.read(fileSortTypeProvider.notifier).update(SortType.defaultSort);
}

void toTheCenter(WidgetRef ref, FileInfo file) {
  List<FileInfo> files = ref.watch(sortListProvider);
  int index = files.indexWhere((e) => e == file);
  if (index == files.length ~/ 2) return;
  deleteOne(ref, file.id);
  insertCenter(ref, file);
  ref.read(fileSortTypeProvider.notifier).update(SortType.defaultSort);
}

void toTheLast(WidgetRef ref, FileInfo file) {
  List<FileInfo> files = ref.watch(sortListProvider);
  int index = files.indexWhere((e) => e == file);
  if (index == files.length - 1) return;
  deleteOne(ref, file.id);
  insertLast(ref, file);
  ref.read(fileSortTypeProvider.notifier).update(SortType.defaultSort);
}

Future<void> addTray() async {
  String icon = Platform.isWindows ? AppImages.logoWin : AppImages.logo;
  await trayManager.setIcon(icon);
  trayManager.setToolTip(AppText.name);
  Menu menu = Menu(
    items: [
      MenuItem(
        key: AppKeys.cancelOperate,
        label: S.current.cancelOperation,
      ),
      MenuItem(
        key: AppKeys.showWindow,
        label: S.current.showWindow,
      ),
      MenuItem.separator(),
      MenuItem(
        key: AppKeys.exitApp,
        label: S.current.exitApp,
      ),
    ],
  );
  await trayManager.setContextMenu(menu);
}
