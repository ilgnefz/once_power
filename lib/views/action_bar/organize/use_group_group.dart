import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/action_bar/easy_btn.dart';
import 'package:once_power/widgets/action_bar/two_checkbox_group.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class UseGroupGroup extends ConsumerWidget {
  const UseGroupGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TwoCheckboxGroup(
      left: AppNum.defaultP,
      children: [
        EasyBtn(
          S.of(context).groupType,
          height: 30,
          onTap: () => showAllGroup(context),
        ),
        EasyCheckbox(
          checked: ref.watch(useGroupOrganizeProvider),
          label: S.of(context).useGroup,
          onChanged: (value) {
            ref.read(useGroupOrganizeProvider.notifier).toggle();
            ref.read(useRuleOrganizeProvider.notifier).update(false);
            ref.read(useDateClassifyProvider.notifier).update(false);
            ref.read(useTopParentsProvider.notifier).update(false);
          },
        ),
      ],
    );
  }
}
