import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/csv_rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class DeleteExtensionCheckbox extends ConsumerWidget {
  const DeleteExtensionCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyCheckbox(
      checked: ref.watch(isDeleteExtensionProvider),
      label: S.of(context).deleteExtension,
      onChanged: (value) {
        ref.read(isDeleteExtensionProvider.notifier).update();
        cSVDataRename(ref);
      },
    );
  }
}
