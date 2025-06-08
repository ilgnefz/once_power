import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/action_bar/easy_btn.dart';
import 'package:once_power/widgets/action_bar/two_checkbox_group.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class UseRuleGroup extends ConsumerWidget {
  const UseRuleGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TwoCheckboxGroup(
      left: AppNum.defaultP,
      children: [
        EasyBtn(
          S.of(context).classifyType,
          height: 30,
          onTap: () => showAllRule(context),
        ),
        EasyCheckbox(
          checked: ref.watch(useRuleOrganizeProvider),
          label: S.of(context).useRule,
          onChanged: (value) {
            ref.read(useRuleOrganizeProvider.notifier).toggle();
            ref.read(useGroupOrganizeProvider.notifier).update(false);
            ref.read(useDateClassifyProvider.notifier).update(false);
            ref.read(useTopParentsProvider.notifier).update(false);
          },
        ),
      ],
    );
  }
}
