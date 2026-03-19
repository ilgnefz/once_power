import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';

import 'setting_checkbox.dart';
import 'setting_view.dart';

class RenameSetting extends StatelessWidget {
  const RenameSetting({
    super.key,
    required this.cancelRename,
    required this.autoRename,
    required this.onCancelChanged,
    required this.onAutoChanged,
  });

  final bool cancelRename;
  final bool autoRename;
  final void Function(bool) onCancelChanged;
  final void Function(bool) onAutoChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        SettingTitle(tr(AppL10n.settingRename)),
        SettingCheckbox(
          label: tr(AppL10n.settingCancelRename),
          checked: cancelRename,
          onChanged: (value) => onCancelChanged(value),
        ),
        SettingCheckbox(
          label: tr(AppL10n.settingAutoRename),
          checked: autoRename,
          onChanged: (value) => onAutoChanged(value),
        ),
      ],
    );
  }
}
