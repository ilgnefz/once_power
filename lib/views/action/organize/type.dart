import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/base/easy_btn.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';

class TypeGroup extends ConsumerWidget {
  const TypeGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyBtn(
            label: tr(AppL10n.organizeTypeFolder),
            onPressed: () => showAllTypeRule(context),
          ),
          EasyCheckbox(
            checked: ref.watch(useTypeOrganizeProvider),
            label: tr(AppL10n.organizeType),
            onChanged: (v) =>
                ref.read(useTypeOrganizeProvider.notifier).toggle(),
          ),
        ],
      ),
    );
  }
}
