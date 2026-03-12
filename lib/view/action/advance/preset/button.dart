import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/action/popver_button.dart';

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
            // PresetList(),
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     ImportPreset(ref),
            //     EasyTextBtn(
            //       tr(AppL10n.advanceExport),
            //       width: AppNum.presetMenu / 2,
            //       onPressed: () {
            //         ctrl.close();
            //         exportPreset(context);
            //       },
            //     ),
            //   ],
            // ),
            // AddPresetBtn(controller: ctrl),
          ],
        ),
      ),
    );
  }
}
