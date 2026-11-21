import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/action/item.dart';

class IndexInput extends ConsumerWidget {
  const IndexInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      icon: AppIcons.date,
      tip: context.tr(AppL10n.prefixSwap),
      checked: ref.watch(isSwapPrefixProvider),
      onIconPressed: ref.read(isSwapPrefixProvider.notifier).toggle,
      child: const Icon(Icons.date_range),
    );
  }
}
