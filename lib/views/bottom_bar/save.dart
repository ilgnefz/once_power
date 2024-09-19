import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class SaveBtn extends ConsumerWidget {
  const SaveBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String tip = S.of(context).saveConfig;

    bool selected = ref.watch(saveConfigProvider);

    return TooltipIcon(
      message: tip,
      icon: AppIcons.save,
      selected: selected,
      onTap: ref.read(saveConfigProvider.notifier).update,
    );
  }
}
