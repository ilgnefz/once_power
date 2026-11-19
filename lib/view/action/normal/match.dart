import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/base/input.dart';

class MatchInput extends ConsumerWidget {
  const MatchInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      tip: context.tr(AppL10n.length),
      icon: AppIcons.ruler,
      checked: ref.watch(isInputLengthProvider),
      onIconPressed: ref.read(isInputLengthProvider.notifier).toggle,
      child: BaseInput(
        hintText: context.tr(AppL10n.match),
        onChanged: (value) {},
      ),
    );
  }
}
