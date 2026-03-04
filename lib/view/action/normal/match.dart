import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/core/update/normal.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/util/debounce.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/common/text_input.dart';

class MatchInput extends ConsumerWidget {
  const MatchInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      icon: AppIcons.ruler,
      tip: tr(AppL10n.renameLen),
      checked: ref.watch(isInputLenProvider),
      onPressed: ref.read(isInputLenProvider.notifier).update,
      child: TextInput(
        controller: ref.watch(matchControllerProvider),
        hintText: tr(AppL10n.renameMatch),
        onChange: (_) => Debounce.run(() => normalUpdateName(ref)),
      ),
    );
  }
}
