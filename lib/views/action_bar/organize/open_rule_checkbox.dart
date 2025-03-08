import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class OpenRuleCheckbox extends ConsumerWidget {
  const OpenRuleCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyCheckbox(
      checked: ref.watch(useRuleOrganizeProvider),
      label: S.of(context).useRule,
      onChanged: (value) {
        ref.read(useRuleOrganizeProvider.notifier).toggle();
        ref.read(useDateClassifyProvider.notifier).update(false);
        ref.read(useTopParentsProvider.notifier).update(false);
      },
    );
  }
}
