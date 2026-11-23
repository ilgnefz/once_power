import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:once_power/widget/base/text.dart';

class AdvancedTop extends ConsumerWidget {
  const AdvancedTop({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: AppNumber.widgetHeight,
      padding: EdgeInsets.symmetric(horizontal: AppNumber.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OneLineText(
            context.tr(AppL10n.presetTotal, namedArgs: {'count': '0'}),
            fontSize: 13,
            color: Colors.grey,
          ),
          ClickIcon(
            size: 20,
            iconSize: 16,
            icon: Icons.delete_outline_rounded,
            color: Colors.grey,
            onPressed: () {
              // ref.read(advanceMenuListProvider.notifier).setList([]);
              // ref.read(currentPresetNameProvider.notifier).update('');
              // advanceUpdateName(ref);
            },
          ),
        ],
      ),
    );
  }
}
