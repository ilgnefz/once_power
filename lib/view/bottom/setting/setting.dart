import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/widget/bottom/icon.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomClickIcon(
      tip: tr(AppL10n.bottomView),
      icon: Icons.settings_rounded,
      onPressed: () => showSettingView(context),
    );
  }
}
