import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class TipBtn extends ConsumerWidget {
  const TipBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String tip1 = tr(AppL10n.bottomHotKey);
    final String tip2 = tr(AppL10n.bottomHotKeyAll);
    final String tip3 = tr(AppL10n.bottomHotKeyDelete);
    final String tip4 = tr(AppL10n.bottomHotKeyToggle);
    final String tip5 = tr(AppL10n.bottomHotKeySuspense);
    final String tip6 = tr(AppL10n.bottomHotKeyFront);
    final String tip7 = tr(AppL10n.bottomHotKeyBehind);
    return TooltipIcon(
      tip:
          '$tip1:\nCtrl+A  $tip2\nDelete  $tip3\nCtrl+S  $tip4\nCtrl+X  $tip5\nCtrl+C  $tip6\nCtrl+V  $tip7',
      icon: Icons.tips_and_updates_rounded,
      selected: false,
      onPressed: () {},
    );
  }
}
