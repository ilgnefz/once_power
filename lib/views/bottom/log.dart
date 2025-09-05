import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class LogBtn extends ConsumerWidget {
  const LogBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TooltipIcon(
      tip: tr(AppL10n.bottomLog),
      svg: AppIcons.log,
      selected: ref.watch(isSaveLogProvider),
      onTap: ref.read(isSaveLogProvider.notifier).update,
    );
  }
}
