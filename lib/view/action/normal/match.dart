import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/core/update/normal.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/util/debounce.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/common/input_field.dart';

final Provider<bool> _enableProvider = Provider((Ref ref) {
  FunctionMode mode = ref.watch(currentModeProvider);
  bool modifyIsEmpty = ref.watch(modifyIsEmptyProvider);
  switch (mode) {
    case FunctionMode.replace:
      return !ref.watch(isDateRenameProvider);
    case FunctionMode.reserve:
      if (!modifyIsEmpty && !ref.watch(matchIsEmptyProvider)) {
        return ref.watch(selectedReserveTypeProvider).isEmpty;
      }
      return ref.watch(selectedReserveTypeProvider).isEmpty && modifyIsEmpty;
    default:
      return true;
  }
});

class MatchInput extends ConsumerWidget {
  const MatchInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      icon: AppIcons.ruler,
      tip: tr(AppL10n.renameLen),
      checked: ref.watch(isInputLenProvider),
      onPressed: ref.read(isInputLenProvider.notifier).update,
      child: InputField(
        controller: ref.watch(matchControllerProvider),
        hintText: tr(AppL10n.renameMatch),
        enabled: ref.watch(_enableProvider),
        onChanged: (_) => Debounce.run(() => normalUpdateName(ref)),
      ),
    );
  }
}
