import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class CaseFileCheckbox extends ConsumerWidget {
  const CaseFileCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyCheckbox(
      checked: ref.watch(caseFileProvider),
      onChanged: (value) {
        ref.read(caseFileProvider.notifier).update();
        updateName(ref);
      },
      child: Text(S.of(context).caseFile),
    );
  }
}
