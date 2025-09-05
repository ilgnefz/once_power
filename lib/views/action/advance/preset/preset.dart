import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/views/action/advance/preset/add.dart';
import 'package:once_power/views/action/advance/preset/export.dart';
import 'package:once_power/views/action/advance/preset/import.dart';
import 'package:once_power/widgets/action/popover_btn.dart';

import 'presets.dart';

class PresetBtn extends StatelessWidget {
  const PresetBtn({super.key});

  @override
  Widget build(BuildContext context) {
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
                Expanded(child: ImportPreset(controller: ctrl)),
                Expanded(child: ExportPreset(controller: ctrl)),
              ],
            ),
            AddPreset(controller: ctrl),
          ],
        ),
      ),
    );
  }
}
