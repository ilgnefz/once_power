import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class TopParentsCheckbox extends ConsumerWidget {
  const TopParentsCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyCheckbox(
      label: S.of(context).topParentFolder,
      checked: ref.watch(useTopParentsProvider),
      onChanged: (value) {
        ref.read(useTopParentsProvider.notifier).toggle();
        ref.read(useDateClassifyProvider.notifier).update(false);
        ref.read(useRuleOrganizeProvider.notifier).update(false);
      },
    );
  }
}
