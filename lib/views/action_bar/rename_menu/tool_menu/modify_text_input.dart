import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/widgets/input/input.dart';

class ModifyTextInput extends ConsumerWidget {
  const ModifyTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String caseDesc = S.of(context).caseDesc;
    final String modifyTo = S.of(context).modifyTo;
    final String inputDisable = S.of(context).inputDisable;

    bool dateRename = ref.watch(dateRenameProvider);
    bool reverseMode = ref.watch(currentModeProvider) == FunctionMode.reserve;
    bool inputNotEmpty = ref.watch(matchClearProvider);
    bool reserveTypeEmpty = ref.watch(currentReserveTypeProvider).isNotEmpty;
    bool disable =
        dateRename || (reverseMode && (inputNotEmpty || reserveTypeEmpty));

    void toggleCase() {
      ref.read(matchCaseProvider.notifier).update();
      updateName(ref);
    }

    return CommonInputMenu(
      disable: disable,
      controller: ref.watch(modifyControllerProvider),
      hintText: disable ? inputDisable : modifyTo,
      show: ref.watch(modifyClearProvider),
      onChanged: (v) => updateName(ref),
      message: caseDesc,
      icon: AppIcons.cases,
      selected: ref.watch(matchCaseProvider),
      onTap: toggleCase,
    );
  }
}
