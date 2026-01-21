import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/bottom/icon.dart';

class SaveButton extends ConsumerWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomClickIcon(
      tip: '${tr(AppL10n.bottomSave)} ${tr(AppL10n.bottomSaveTip)}',
      svg: AppIcons.save,
      selected: ref.watch(isSaveConfigProvider),
      onPressed: ref.read(isSaveConfigProvider.notifier).update,
      // onLongPress: () => showSaveView(context),
    );
  }
}
