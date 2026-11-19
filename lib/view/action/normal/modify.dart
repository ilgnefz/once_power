import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/base/input.dart';

class ModifyInput extends ConsumerWidget {
  const ModifyInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      tip: context.tr(AppL10n.ignore),
      icon: AppIcons.cases,
      checked: ref.watch(isIgnoreCaseProvider),
      onIconPressed: ref.read(isIgnoreCaseProvider.notifier).toggle,
      child: BaseInput(
        hintText: context.tr(AppL10n.modify),
        onChanged: (value) {},
        suffixIcon: AppIcons.today,
        suffixTip: context.tr(AppL10n.today),
        onSuffixPressed: () {},
      ),
    );
  }
}
