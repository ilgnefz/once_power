import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/widget/action/elevated_button.dart';

class ApplyButton extends ConsumerWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyElevatedButton(
      label: tr(AppL10n.renameApply),
      onPressed: () async => await runRename(ref),
    );
  }
}
