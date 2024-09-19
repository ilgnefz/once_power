import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/action_bar/action_input.dart';

class ExtensionInput extends ConsumerWidget {
  const ExtensionInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool disable = !ref.read(modifyExtensionProvider);
    final String fileExtensionLabel = S.of(context).fileExtension;
    final String fileExtensionHint =
        disable ? S.of(context).inputDisable : S.of(context).fileExtensionDesc;
    final String fileExtensionTip = S.of(context).extensionDesc;

    void enableToggleInput() {
      ref.read(modifyExtensionProvider.notifier).update();
      ref.read(extensionControllerProvider).clear();
      updateExtension(ref);
    }

    return ActionInput(
      disable: disable,
      label: fileExtensionLabel,
      controller: ref.watch(extensionControllerProvider),
      hintText: fileExtensionHint,
      show: ref.watch(extensionClearProvider),
      message: fileExtensionTip,
      icon: AppIcons.checkbox,
      selected: ref.watch(modifyExtensionProvider),
      onChanged: (v) => updateExtension(ref),
      onTap: enableToggleInput,
    );
  }
}
