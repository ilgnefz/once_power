import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class LogBtn extends ConsumerWidget {
  const LogBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TooltipIcon(
      tip: S.of(context).saveLog,
      svg: AppIcons.log,
      selected: ref.watch(isSaveLogProvider),
      onTap: ref.read(isSaveLogProvider.notifier).update,
    );
  }
}
