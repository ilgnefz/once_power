import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/bottom/icon.dart';

class ViewButton extends ConsumerWidget {
  const ViewButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomClickIcon(
      tip: context.tr(AppL10n.view),
      svg: AppIcons.image,
      selected: ref.watch(isViewModeProvider),
      onPressed: () {
        ref.read(isViewModeProvider.notifier).toggle();
        // if (ref.read(isViewModeProvider) &&
        //     !ref.read(currentModeProvider).isOrganize) {
        //   filterFile(ref);
        //   updateName(ref);
        // }
      },
    );
  }
}
