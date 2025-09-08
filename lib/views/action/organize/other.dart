import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';

class OtherGroup extends ConsumerWidget {
  const OtherGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppNum.paddingMedium,
        right: AppNum.padding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyCheckbox(
            checked: ref.watch(useTopFolderProvider),
            label: tr(AppL10n.organizeTop),
            onChanged: (v) {
              ref.read(useTopFolderProvider.notifier).toggle();
              ref.read(useGroupOrganizeProvider.notifier).update(false);
              ref.read(useTypeOrganizeProvider.notifier).update(false);
              ref.read(useDateOrganizeProvider.notifier).update(false);
            },
          ),
          EasyCheckbox(
            checked: ref.watch(useDateOrganizeProvider),
            label: tr(AppL10n.organizeDate),
            onChanged: (v) {
              ref.read(useDateOrganizeProvider.notifier).toggle();
              ref.read(useGroupOrganizeProvider.notifier).update(false);
              ref.read(useTypeOrganizeProvider.notifier).update(false);
              ref.read(useTopFolderProvider.notifier).update(false);
            },
          ),
        ],
      ),
    );
  }
}
