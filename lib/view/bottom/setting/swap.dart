import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/provider/toggle.dart';

import 'setting_checkbox.dart';

class SwapLabelSetting extends ConsumerWidget {
  const SwapLabelSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingCheckbox(
      label: tr(AppL10n.settingSwapLabel),
      checked: ref.watch(swapLabelProvider),
      onChanged: (value) => ref.read(swapLabelProvider.notifier).update(),
    );
  }
}
