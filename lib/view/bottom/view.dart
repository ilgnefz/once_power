import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/core/update.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/bottom/icon.dart';

class ViewButton extends ConsumerWidget {
  const ViewButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomClickIcon(
      tip: tr(AppL10n.bottomView),
      svg: AppIcons.image,
      selected: ref.watch(isViewModeProvider),
      onPressed: () {
        ref.read(isViewModeProvider.notifier).update();
        if (ref.read(isViewModeProvider)) {
          // filterFile(ref);
          updateName(ref);
        }
      },
    );
  }
}
