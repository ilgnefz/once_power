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

class ExtensionInput extends ConsumerWidget {
  const ExtensionInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      label: tr(AppL10n.renameExt),
      icon: AppIcons.extension,
      tip: tr(AppL10n.renameExtEnable),
      checked: ref.watch(isModifyExtensionProvider),
      onPressed: () {
        ref.read(isModifyExtensionProvider.notifier).update();
        Debounce.run(() => normalUpdateName(ref));
      },
      child: TextInput(
        controller: ref.watch(extensionControllerProvider),
        hintText: tr(AppL10n.renameExtHint),
        onChanged: (_) => Debounce.run(() => normalUpdateName(ref)),
      ),
    );
  }
}
