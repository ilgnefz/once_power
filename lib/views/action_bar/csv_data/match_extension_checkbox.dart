import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/csv_rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class MatchExtensionCheckbox extends ConsumerWidget {
  const MatchExtensionCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyCheckbox(
      checked: ref.watch(isMatchExtensionProvider),
      label: S.of(context).matchExtension,
      onChanged: (value) {
        ref.read(isMatchExtensionProvider.notifier).update();
        cSVDataRename(ref);
      },
    );
  }
}
