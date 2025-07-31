import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/utils/preset_encryptor.dart';
import 'package:once_power/widgets/action_bar/easy_text_btn.dart';
import 'package:once_power/widgets/common/popover_btn.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

import 'preset_item.dart';

class PresetBtn extends ConsumerWidget {
  const PresetBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AdvancePreset> list = ref.watch(advancePresetListProvider);

    return PopoverBtn(
      placement: Placement.top,
      builder: (ctrl) => ColoredBox(
        color: Theme.of(context).colorScheme.onSurface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(
              list.length,
              (index) {
                return PresetItem(
                  '${index + 1}. ${list[index].name}',
                  key: ValueKey(list[index].id),
                  onTap: () {
                    // ctrl.close();
                    List<AdvanceMenuModel> menus = [];
                    menus.addAll(list[index].menus.map((e) => e.copyWith()));
                    ref.read(advanceMenuListProvider.notifier).setList(menus);
                    advanceUpdateName(ref);
                  },
                  onRename: () {
                    AdvancePreset p = list[index];
                    renamePreset(context, p);
                  },
                  onAppend: () {
                    AdvancePreset p = list[index];
                    final menus =
                        p.menus.map((e) => e.copyWith(id: nanoid(10))).toList();
                    ref.read(advanceMenuListProvider.notifier).addAll(menus);
                    advanceUpdateName(ref);
                    // ctrl.close();
                  },
                  onRemove: () {
                    AdvancePreset p = list[index];
                    ref.read(advancePresetListProvider.notifier).remove(p);
                    // ctrl.close();
                  },
                );
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                EasyTextBtn(
                  S.current.importPreset,
                  width: AppNum.presetMenuW / 2,
                  onTap: () async {
                    ctrl.close();
                    try {
                      final result = await openFile(acceptedTypeGroups: [
                        XTypeGroup(
                          label: 'OncePower${S.current.preset}',
                          extensions: [PresetEncryptor.extension],
                        )
                      ]);
                      if (result == null) return;
                      final file = File(result.path);
                      final fileBytes = await file.readAsBytes();
                      // 调用工具类解密方法
                      List<AdvancePreset> value =
                          PresetEncryptor.decryptPresets(fileBytes);
                      // 过滤和list中相同的值
                      List<AdvancePreset> newPresets = [];
                      // 先快速过滤id重复的
                      List<String> ids = list.map((e) => e.id).toList();
                      for (var preset in value) {
                        if (!ids.contains(preset.id)) {
                          newPresets.add(preset);
                          continue;
                        }
                        // id重复时才比较整个对象
                        var existing =
                            list.firstWhere((p) => p.id == preset.id);
                        if (existing.toString() != preset.toString()) {
                          newPresets.add(preset.copyWith(id: nanoid(10)));
                        }
                      }
                      if (newPresets.isNotEmpty) {
                        ref
                            .read(advancePresetListProvider.notifier)
                            .addAll(newPresets);
                      }
                      showPresetImportNotification(num: value.length);
                      debugPrint(value.toString());
                    } catch (e) {
                      showPresetImportNotification(err: e.toString());
                    }
                  },
                ),
                EasyTextBtn(
                  S.current.exportPreset,
                  width: AppNum.presetMenuW / 2,
                  onTap: () {
                    ctrl.close();
                    exportPreset(context);
                  },
                ),
              ],
            ),
            EasyTextBtn(
              S.of(context).addPreset,
              onTap: () {
                ctrl.close();
                final current = ref.read(advanceMenuListProvider);
                final copies = current.map((e) => e.copyWith()).toList();
                addPreset(context, ref, copies);
              },
            ),
          ],
        ),
      ),
      child: Text(
        S.of(context).preset,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
