import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/debounce.dart';
import 'package:once_power/widgets/action/action_item.dart';
import 'package:once_power/widgets/base/base_input.dart';

final _enableMatchProvider = Provider<bool>((ref) {
  FunctionMode mode = ref.watch(currentModeProvider);
  if (mode.isReplace) {
    return !ref.watch(isDateRenameProvider);
  }
  if (mode.isReserve) {
    return ref.watch(selectedReserveTypeProvider).isEmpty &&
        !ref.watch(isDateRenameProvider) &&
        !ref.watch(modifyClearProvider);
  }
  return true;
});

class MatchInput extends ConsumerWidget {
  const MatchInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool enable = ref.watch(_enableMatchProvider);
    return ActionItem(
      tip: tr(AppL10n.renameLen),
      icon: AppIcons.ruler,
      checked: ref.watch(isInputLenProvider),
      onPressed: () {
        ref.read(isInputLenProvider.notifier).update();
        Debounce.run(() => updateName(ref));
      },
      child: BaseInput(
        hintText: enable ? tr(AppL10n.renameMatch) : tr(AppL10n.renameDisable),
        controller: ref.watch(matchControllerProvider),
        show: ref.watch(matchClearProvider),
        enable: enable,
        onClear: () {
          ref.read(matchControllerProvider.notifier).clear();
          updateName(ref);
        },
        onChanged: (value) => Debounce.run(() => updateName(ref)),
      ),
    );
  }
}
