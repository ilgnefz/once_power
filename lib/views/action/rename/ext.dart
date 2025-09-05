import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/debounce.dart';
import 'package:once_power/widgets/action/action_item.dart';
import 'package:once_power/widgets/base/base_input.dart';

class ExtInput extends ConsumerWidget {
  const ExtInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool modify = ref.watch(isModifyExtProvider);
    String hintText = modify
        ? tr(AppL10n.renameExtHint)
        : tr(AppL10n.renameDisable);
    return ActionItem(
      label: tr(AppL10n.renameExt),
      tip: tr(AppL10n.renameExtEnable),
      icon: AppIcons.extension,
      checked: modify,
      onPressed: () {
        ref.read(isModifyExtProvider.notifier).update();
        Debounce.run(() => updateName(ref));
      },
      child: BaseInput(
        controller: ref.watch(extensionControllerProvider),
        hintText: hintText,
        show: ref.watch(extensionClearProvider),
        onClear: () {
          ref.read(extensionControllerProvider.notifier).clear();
          updateName(ref);
        },
        enable: modify,
        onChanged: (value) => Debounce.run(() => updateName(ref)),
      ),
    );
  }
}
