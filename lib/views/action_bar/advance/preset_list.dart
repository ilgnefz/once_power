import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/providers/value.dart';

import 'preset_item.dart';

class PresetList extends ConsumerWidget {
  const PresetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AdvancePreset> list = ref.watch(advancePresetListProvider);
    return Flexible(
      fit: FlexFit.loose,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return PresetItem(
            '${index + 1}. ${list[index].name}',
            key: ValueKey(list[index].id),
            onTap: () {
              // ctrl.close();
              List<AdvanceMenuModel> menus = [];
              menus.addAll(list[index].menus.map((e) => e.copyWith()));
              ref.read(advanceMenuListProvider.notifier).setList(menus);
              ref
                  .read(currentPresetNameProvider.notifier)
                  .update(list[index].name);
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
              ref.read(currentPresetNameProvider.notifier).update('');
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
    );
  }
}
