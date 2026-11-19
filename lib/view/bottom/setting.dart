import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/widget/bottom/icon.dart';

class SettingButton extends ConsumerWidget {
  const SettingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomClickIcon(
      tip: context.tr(AppL10n.setting),
      icon: Icons.settings_rounded,
      // selected: ref.watch(isViewModeProvider),
      onPressed: () async => showSettingView(context),
    );
  }
}
