import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/core/update.dart';
import 'package:once_power/util/debounce.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/text_input.dart';

class AffixInput extends ConsumerWidget {
  const AffixInput({
    super.key,
    required this.label,
    required this.hintText,
    required this.tip,
    required this.controllerProvider,
    required this.cycleProvider,
  });

  final String label;
  final String hintText;
  final String tip;
  final dynamic controllerProvider;
  final dynamic cycleProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      label: label,
      tip: tip,
      icon: AppIcons.cycle,
      checked: ref.watch(cycleProvider),
      onPressed: () {
        ref.read(cycleProvider.notifier).update();
        Debounce.run(() => normalUpdateName(ref));
      },
      child: TextInput(
        controller: ref.watch(controllerProvider),
        hintText: hintText,
        action: ClickIcon(
          tip: tr(AppL10n.renameUpload),
          icon: Icons.upload_file_rounded,
          onPressed: () {},
        ),
      ),
    );
  }
}
