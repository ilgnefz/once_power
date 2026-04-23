import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/provider/setting.dart';

import 'setting_checkbox.dart';
import 'setting_view.dart';

class VisualSetting extends ConsumerWidget {
  const VisualSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        SettingTitle(tr(AppL10n.settingVisual)),
        SettingCheckbox(
          label: tr(AppL10n.settingTip),
          checked: ref.watch(hiddenTipProvider),
          onChanged: (_) => ref.read(hiddenTipProvider.notifier).update(),
        ),
      ],
    );
  }
}
