import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/providers/advance.dart';
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
      builder: (ctrl) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(
            list.length,
            (index) {
              return PresetItem(
                '${index + 1}. ${list[index].name}',
                key: ValueKey(list[index].id),
                onTap: () {
                  ctrl.close();
                  List<AdvanceMenuModel> menus = [];
                  menus.addAll(list[index].menus.map((e) => e.copyWith()));
                  ref.read(advanceMenuListProvider.notifier).setList(menus);
                  advanceUpdateName(ref);
                },
                onAppend: () {
                  AdvancePreset p = list[index];
                  final menus =
                      p.menus.map((e) => e.copyWith(id: nanoid(10))).toList();
                  ref.read(advanceMenuListProvider.notifier).addAll(menus);
                  advanceUpdateName(ref);
                  ctrl.close();
                },
                onRemove: () {
                  AdvancePreset p = list[index];
                  ref.read(advancePresetListProvider.notifier).remove(p);
                  ctrl.close();
                },
              );
            },
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
      child: Text(
        S.of(context).preset,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
