import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class TargetInput extends ConsumerWidget {
  const TargetInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: BaseInput(
        hintText: tr(AppL10n.organizeTarget),
        controller: ref.watch(folderControllerProvider),
        show: ref.watch(folderClearProvider),
        onClear: ref.read(folderControllerProvider.notifier).clear,
        trailing: ClickIcon(icon: Icons.folder_open_rounded, onPressed: () {}),
      ),
    );
  }
}
