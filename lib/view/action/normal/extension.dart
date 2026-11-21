import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/action/input.dart';
import 'package:once_power/widget/action/item.dart';

class ExtensionInput extends ConsumerWidget {
  const ExtensionInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      label: context.tr(AppL10n.extension),
      tip: context.tr(AppL10n.extensionEnable),
      icon: AppIcons.extension,
      checked: ref.watch(isModifyExtensionProvider),
      onIconPressed: ref.read(isModifyExtensionProvider.notifier).toggle,
      child: EasyInput(
        hintText: context.tr(AppL10n.extensionHint),
        value: ref.watch(extensionProvider),
        onChanged: ref.read(extensionProvider.notifier).update,
      ),
    );
  }
}
