import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/view/bottom/setting/swap.dart';

import 'setting_checkbox.dart';
import 'setting_view.dart';

class RenameSetting extends StatelessWidget {
  const RenameSetting({
    super.key,
    required this.cancelRename,
    required this.onCancelChanged,
  });

  final bool cancelRename;
  final void Function(bool) onCancelChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        SettingTitle(tr(AppL10n.settingRename)),
        SwapLabelSetting(),
        SettingCheckbox(
          label: tr(AppL10n.settingCancelRename),
          checked: cancelRename,
          onChanged: onCancelChanged,
        ),
        SettingCheckbox(
          label: tr(AppL10n.settingAutoRename),
          checked: true,
          disabled: true,
          onChanged: (_) {},
        ),
      ],
    );
  }
}
