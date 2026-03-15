import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/organize.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/common/checkbox.dart';

class OtherGroup extends ConsumerWidget {
  const OtherGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: .only(left: AppNum.paddingMedium, right: AppNum.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyCheckbox(
            checked: ref.watch(currentOrganizeModeProvider).isTop,
            label: tr(AppL10n.organizeTop),
            onChanged: (value) {
              final provider = ref.read(currentOrganizeModeProvider.notifier);
              provider.update(value! ? OrganizeMode.top : OrganizeMode.normal);
            },
          ),
          EasyCheckbox(
            checked: ref.watch(currentOrganizeModeProvider).isDate,
            label: tr(AppL10n.organizeDate),
            onChanged: (value) {
              final provider = ref.read(currentOrganizeModeProvider.notifier);
              provider.update(value! ? OrganizeMode.date : OrganizeMode.normal);
            },
          ),
        ],
      ),
    );
  }
}
