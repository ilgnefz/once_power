import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class LogBtn extends ConsumerWidget {
  const LogBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String tip = S.of(context).saveLog;

    bool selected = ref.watch(saveLogProvider);

    return TooltipIcon(
      message: tip,
      icon: AppIcons.log,
      selected: selected,
      onTap: ref.read(saveLogProvider.notifier).update,
    );
  }
}
