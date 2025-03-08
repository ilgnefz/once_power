import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class DateClassifyCheckbox extends ConsumerWidget {
  const DateClassifyCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyCheckbox(
      label: S.of(context).dateClassification,
      checked: ref.watch(useDateClassifyProvider),
      onChanged: (value) {
        ref.read(useDateClassifyProvider.notifier).toggle();
        ref.read(useRuleOrganizeProvider.notifier).update(false);
        ref.read(useTopParentsProvider.notifier).update(false);
      },
    );
  }
}
