import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/views/action/advance/preset/add.dart';
import 'package:once_power/views/action/advance/preset/import.dart';
import 'package:once_power/widgets/action/popover_btn.dart';
import 'package:once_power/widgets/action/text_btn.dart';

import 'list.dart';

class PresetBtn extends ConsumerWidget {
  const PresetBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopoverBtn(
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
                ImportPreset(ref),
                EasyTextBtn(
                  tr(AppL10n.advanceExport),
                  width: AppNum.presetMenu / 2,
                  onTap: () {
                    ctrl.close();
                    exportPreset(context);
                  },
                ),
              ],
            ),
            AddPresetBtn(controller: ctrl),
          ],
        ),
      ),
    );
  }
}
