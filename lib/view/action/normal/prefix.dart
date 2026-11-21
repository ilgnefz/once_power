import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/action/input.dart';
import 'package:once_power/widget/action/item.dart';

class PrefixInput extends ConsumerWidget {
  const PrefixInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      label: context.tr(AppL10n.prefix),
      tip: context.tr(AppL10n.prefixCircle),
      icon: AppIcons.cycle,
      checked: ref.watch(isCyclePrefixProvider),
      onIconPressed: ref.read(isCyclePrefixProvider.notifier).toggle,
      child: EasyInput(
        hintText: context.tr(AppL10n.prefixHint),
        onChanged: (value) {},
        suffixIcon: AppIcons.fileUp,
        suffixTip: context.tr(AppL10n.upload),
        onSuffixPressed: () {},
      ),
    );
  }
}
