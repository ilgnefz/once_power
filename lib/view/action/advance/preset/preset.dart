import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/core/preset.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/util/notification.dart';
import 'package:once_power/widget/action/popver_button.dart';
import 'package:once_power/widget/common/click_text.dart';

import 'list.dart';

class PresetButton extends ConsumerWidget {
  const PresetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopoverButton(
      label: tr(AppL10n.advancePreset),
      builder: (ctrl) => Container(
        width: AppNum.presetMenu,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PresetList(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                EasyClickText(
                  label: tr(AppL10n.advanceImport),
                  width: AppNum.presetMenu / 2,
                  onPressed: () => importPreset(ref),
                ),
                EasyClickText(
                  label: tr(AppL10n.advanceExport),
                  width: AppNum.presetMenu / 2,
                  onPressed: () async {
                    ctrl.close();
                    await showExportPreset(context);
                  },
                ),
              ],
            ),
            EasyClickText(
              label: tr(AppL10n.advanceAddPreset),
              width: AppNum.presetMenu,
              onPressed: () async {
                ctrl.close();
                final current = ref.read(advanceMenuListProvider);
                final copies = current.map((e) => e.copyWith()).toList();
                if (copies.isEmpty) return showPresetEmptyNotification();
                await showAddExport(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
