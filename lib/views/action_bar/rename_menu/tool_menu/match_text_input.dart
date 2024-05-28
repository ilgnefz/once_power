import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/model.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/widgets/input/input.dart';

class MatchTextInput extends ConsumerWidget {
  const MatchTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool useLength = ref.watch(inputLengthProvider);
    final String matchLength =
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

    return CommonInputMenu(
      disable: disable,
      controller: ref.watch(matchControllerProvider),
      hintText: disable ? inputDisable : matchLength,
      show: ref.watch(matchClearProvider),
      onChanged: (v) => updateName(ref),
      message: lengthDesc,
      icon: AppIcons.ruler,
      selected: ref.watch(inputLengthProvider),
      onTap: toggleLengthInput,
    );
  }
}
