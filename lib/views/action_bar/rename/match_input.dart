import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/verify.dart';
import 'package:once_power/widgets/action_bar/operate_item.dart';
import 'package:once_power/widgets/base/base_input.dart';

import '../../../cores/update_name.dart';

class MatchInput extends ConsumerWidget {
  const MatchInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isInputLen = ref.watch(isInputLengthProvider);
    return OperateItem(
      icon: AppIcons.ruler,
      tip: S.of(context).lengthDesc,
      selected: isInputLen,
      onToggle: () {
        ref.read(isInputLengthProvider.notifier).update();
        updateName(ref);
      },
      child: BaseInput(
        hintText:
            isInputLen ? S.of(context).matchLength : S.of(context).matchHint,
        controller: ref.watch(matchControllerProvider),
        enable: isEnableMatch(ref),
        showClear: ref.watch(matchClearProvider),
        onClear: () {
          ref.read(matchControllerProvider.notifier).clear();
          updateName(ref);
        },
        onChanged: (v) => updateName(ref),
      ),
    );
  }
}
