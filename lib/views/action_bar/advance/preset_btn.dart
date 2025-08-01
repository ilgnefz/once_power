import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/widgets/action_bar/easy_text_btn.dart';
import 'package:once_power/widgets/common/popover_btn.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

import 'import_btn.dart';
import 'preset_list.dart';

class PresetBtn extends ConsumerWidget {
  const PresetBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopoverBtn(
      placement: Placement.top,
      builder: (ctrl) => Container(
        width: AppNum.presetMenuW,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        color: Theme.of(context).colorScheme.onSurface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PresetList(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImportBtn(ref: ref),
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
