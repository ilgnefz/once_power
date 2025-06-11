import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/action_bar/operate_item.dart';
import 'package:once_power/widgets/base/base_input.dart';

class ExtensionInput extends ConsumerWidget {
  const ExtensionInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool selected = ref.watch(isModifyExtensionProvider);
    return OperateItem(
      label: S.of(context).fileExtension,
      icon: AppIcons.extension,
      tip: S.of(context).extensionDesc,
      selected: selected,
      onToggle: () {
        ref.read(isModifyExtensionProvider.notifier).update();
        updateName(ref);
      },
      child: BaseInput(
        enable: selected,
        hintText: selected
            ? S.of(context).fileExtensionDesc
            : S.of(context).inputDisable,
        controller: ref.watch(extensionControllerProvider),
        showClear: ref.watch(extensionClearProvider),
        onClear: () {
          ref.read(extensionControllerProvider.notifier).clear();
          updateName(ref);
          // updateExtension(ref);
        },
        onChanged: (value) => updateName(ref),
      ),
    );
  }
}
