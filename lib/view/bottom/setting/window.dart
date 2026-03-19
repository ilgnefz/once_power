import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';

import 'setting_checkbox.dart';
import 'setting_view.dart';

class WindowSetting extends StatelessWidget {
  const WindowSetting({
    super.key,
    required this.saveSize,
    required this.savePosition,
    required this.onSizeChanged,
    required this.onPositionChanged,
  });

  final bool saveSize;
  final bool savePosition;
  final void Function(bool) onSizeChanged;
  final void Function(bool) onPositionChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        SettingTitle(tr(AppL10n.settingWindow)),
        SettingCheckbox(
          label: tr(AppL10n.settingSaveSize),
          checked: saveSize,
          onChanged: (value) => onSizeChanged(value),
        ),
        SettingCheckbox(
          label: tr(AppL10n.settingSavePosition),
          checked: savePosition,
          onChanged: (value) => onPositionChanged(value),
        ),
      ],
    );
  }
}
