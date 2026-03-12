import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/common/button.dart';
import 'package:once_power/widget/common/checkbox.dart';

class GroupGroup extends ConsumerWidget {
  const GroupGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: .symmetric(horizontal: AppNum.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyButton(
            label: tr(AppL10n.organizeGroupFolder),
            onPressed: () async => await showAllGroup(context),
          ),
          EasyCheckbox(
            checked: ref.watch(useGroupOrganizeProvider),
            label: tr(AppL10n.organizeGroup),
            onChanged: (v) {
              ref.read(useGroupOrganizeProvider.notifier).toggle();
              ref.read(useTypeOrganizeProvider.notifier).update(false);
              ref.read(useTopFolderProvider.notifier).update(false);
              ref.read(useDateOrganizeProvider.notifier).update(false);
            },
          ),
        ],
      ),
    );
  }
}
