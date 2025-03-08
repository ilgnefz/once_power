import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class SaveBtn extends ConsumerWidget {
  const SaveBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TooltipIcon(
      tip: S.of(context).saveConfig,
      svg: AppIcons.save,
      selected: ref.watch(isSaveConfigProvider),
      onTap: ref.read(isSaveConfigProvider.notifier).update,
    );
  }
}
