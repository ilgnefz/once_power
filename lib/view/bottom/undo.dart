import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/service/storage.dart';
import 'package:once_power/widget/bottom/icon.dart';

class UndoButton extends ConsumerWidget {
  const UndoButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomClickIcon(
      tip: context.tr(AppL10n.undo),
      icon: Icons.undo,
      selected: ref.watch(isViewModeProvider),
      onPressed: () {
        StorageService.clear();
      },
    );
  }
}
