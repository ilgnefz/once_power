import 'package:material_ui/material_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/app.dart';
import 'package:once_power/provider/switch.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:once_power/widget/base/text.dart';

class EmptyView extends ConsumerWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color color = Theme.of(context).colorScheme.primary;
    bool isOrganize = ref.watch(currentModeProvider).isOrganize;
    bool viewInfo = !isOrganize && ref.watch(isViewModeProvider);
    String label = context.tr(viewInfo ? AppL10n.empty2 : AppL10n.empty1);
    return Center(
      child: Column(
        spacing: AppNumber.spaceMedium,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            transitionBuilder: (child, animation) =>
                RotationTransition(turns: animation, child: child),
            child: Center(
              key: ValueKey(viewInfo),
              child: BaseIcon(
                icon: viewInfo ? null : Icons.drive_folder_upload_rounded,
                svg: viewInfo ? AppIcons.image : null,
                size: 88,
                color: color,
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: BaseText(
              key: ValueKey(viewInfo),
              label,
              fontSize: 18,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
