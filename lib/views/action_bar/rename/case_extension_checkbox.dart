import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

import '../../../cores/update_name.dart';

class CaseExtensionCheckbox extends ConsumerWidget {
  const CaseExtensionCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyCheckbox(
      checked: ref.watch(caseExtensionProvider),
      onChanged: (value) {
        ref.read(caseExtensionProvider.notifier).update();
        updateName(ref);
      },
      child: Text(S.of(context).caseExtension),
    );
  }
}
