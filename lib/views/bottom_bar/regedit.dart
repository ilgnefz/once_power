import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class RegeditBtn extends ConsumerWidget {
  const RegeditBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String tip = S.of(context).regeditTip;

    bool selected = ref.watch(useRegeditProvider);

    return TooltipIcon(
      message: tip,
      icon: AppIcons.shortcutMenu,
      selected: selected,
      onTap: ref.read(useRegeditProvider.notifier).update,
    );
  }
}
