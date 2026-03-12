import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/organize.dart';
import 'package:once_power/widget/action/elevated_button.dart';

class DeleteGroup extends ConsumerWidget {
  const DeleteGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: .symmetric(horizontal: AppNum.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyElevatedButton(
            label: tr(AppL10n.organizeSelected),
            onPressed: () async => await deleteSelected(ref),
          ),
          EasyElevatedButton(
            label: tr(AppL10n.organizeEmpty),
            onPressed: () async => await deleteEmptyFolder(ref),
          ),
        ],
      ),
    );
  }
}
