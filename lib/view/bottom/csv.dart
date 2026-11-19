import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/bottom/icon.dart';

class CSVButton extends ConsumerWidget {
  const CSVButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomClickIcon(
      tip: context.tr(AppL10n.csv),
      svg: AppIcons.csv,
      selected: ref.watch(isViewModeProvider),
      onPressed: () {
        ref.read(isViewModeProvider.notifier).toggle();
      },
    );
  }
}
