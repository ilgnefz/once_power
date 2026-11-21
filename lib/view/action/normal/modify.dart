import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/action/input.dart';
import 'package:once_power/widget/action/item.dart';

class ModifyInput extends ConsumerWidget {
  const ModifyInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      tip: context.tr(AppL10n.ignore),
      icon: AppIcons.cases,
      checked: ref.watch(isIgnoreCaseProvider),
      onIconPressed: ref.read(isIgnoreCaseProvider.notifier).toggle,
      child: EasyInput(
        hintText: context.tr(AppL10n.modify),
        value: ref.watch(modifyProvider),
        onChanged: ref.read(modifyProvider.notifier).update,
        suffixIcon: AppIcons.today,
        suffixTip: context.tr(AppL10n.today),
        onSuffixPressed: () {
          ref.read(modifyProvider.notifier).update(DateTime.now().toString());
        },
      ),
    );
  }
}
