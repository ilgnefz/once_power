import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/core/update/advance.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/src/rust/api/file_info.dart';

import 'item.dart';

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
        itemExtent: AppNum.widgetHeight,
        itemBuilder: (BuildContext context, int index) {
          AdvancePreset preset = list[index];
          return PresetItem(
            key: ValueKey(list[index].id),
            label: '${index + 1}. ${preset.name}',
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
            onRename: () => renamePreset(context, preset),
            onAppend: () {
              final menus = preset.menus
                  .map((e) => e.copyWith(id: generateId()))
                  .toList();
              ref.read(advanceMenuListProvider.notifier).addAll(menus);
              ref.read(currentPresetNameProvider.notifier).update('');
              advanceUpdateName(ref);
              // ctrl.close();
            },
            onRemove: () {
              ref.read(advancePresetListProvider.notifier).remove(preset);
              // ctrl.close();
            },
          );
        },
      ),
    );
  }
}
