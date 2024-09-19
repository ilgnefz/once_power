import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/action_bar/action_input.dart';

class MatchInput extends ConsumerWidget {
  const MatchInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool useLength = ref.watch(inputLengthProvider);
    final String hintText =
        useLength ? S.of(context).matchLength : S.of(context).matchHint;
    final String inputDisable = S.of(context).inputDisable;
    final String lengthDesc = S.of(context).lengthDesc;
    bool disable = ref.watch(currentModeProvider) == FunctionMode.reserve &&
        (ref.watch(currentReserveTypeProvider).isNotEmpty ||
            ref.watch(dateRenameProvider) ||
            ref.watch(modifyClearProvider));

    void toggleLengthInput() {
      ref.read(inputLengthProvider.notifier).update();
      updateName(ref);
    }

    return ActionInput(
      disable: disable,
      controller: ref.watch(matchControllerProvider),
      hintText: disable ? inputDisable : hintText,
      show: ref.watch(matchClearProvider),
      onChanged: (v) => updateName(ref),
      message: lengthDesc,
      icon: AppIcons.ruler,
      selected: ref.watch(inputLengthProvider),
      onTap: toggleLengthInput,
    );
  }
}
