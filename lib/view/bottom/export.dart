import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/widget/bottom/icon.dart';

class ExportButton extends ConsumerWidget {
  const ExportButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomClickIcon(
      tip: context.tr(AppL10n.export),
      svg: AppIcons.export,
      // icon: Icons.ios_share_rounded,
      selected: false,
      onPressed: () {},
    );
  }
}
