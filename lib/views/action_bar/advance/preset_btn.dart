import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/widgets/action_bar/easy_text_btn.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

import 'preset_item.dart';

class PresetBtn extends ConsumerWidget {
  const PresetBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AdvancePreset> list = ref.watch(advancePresetListProvider);

    return TolyPopover(
      placement: Placement.top,
      overlayBuilder: (context, ctrl) => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Material(
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
                      ctrl.close();
                      List<AdvanceMenuModel> menus = [];
                      menus.addAll(list[index].menus.map((e) => e.copyWith()));
                      ref.read(advanceMenuListProvider.notifier).setList(menus);
                      advanceUpdateName(ref);
                    },
                    onRemove: () {
                      AdvancePreset p = list[index];
                      ctrl.close();
                      ref.read(advancePresetListProvider.notifier).remove(p);
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
        ),
      ),
      builder: (_, ctrl, __) => TextButton(
        onPressed: ctrl.open,
        child: Text(S.of(context).preset),
      ),
    );
  }
}
