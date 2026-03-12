import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/common/button.dart';
import 'package:once_power/widget/common/checkbox.dart';

class TypeGroup extends ConsumerWidget {
  const TypeGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: .symmetric(horizontal: AppNum.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyButton(
            label: tr(AppL10n.organizeTypeFolder),
            onPressed: () async => await showAllTypeRule(context),
          ),
          EasyCheckbox(
            checked: ref.watch(useTypeOrganizeProvider),
            label: tr(AppL10n.organizeType),
            onChanged: (v) {
              ref.read(useTypeOrganizeProvider.notifier).toggle();
              ref.read(useGroupOrganizeProvider.notifier).update(false);
              ref.read(useTopFolderProvider.notifier).update(false);
              ref.read(useDateOrganizeProvider.notifier).update(false);
            },
          ),
        ],
      ),
    );
  }
}
