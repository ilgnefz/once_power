import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/action/input.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/base/tooltip.dart';

class ReplaceInserterGroup extends StatelessWidget {
  const ReplaceInserterGroup({
    super.key,
    required this.selected,
    required this.inserter,
    required this.onInserterChanged,
  });

  final bool selected;
  final String inserter;
  final void Function(String) onInserterChanged;

  @override
  Widget build(BuildContext context) {
    return SelectedBox(
      selected: selected,
      child: Row(
        crossAxisAlignment: .center,
        children: [
          BaseText('${context.tr(AppL10n.replaceWord)}:'),
          const SizedBox(width: AppNumber.spaceMedium),
          SizedBox(
            height: AppNumber.widgetHeight,
            width: 320.0,
            child: EasyInput(
              hintText: context.tr(AppL10n.replaceWordHint),
              onChanged: onInserterChanged,
            ),
          ),
          const SizedBox(width: AppNumber.spaceSmall),
          EasyTooltip(
            waitDuration: .zero,
            tip: context.tr(AppL10n.replaceWordTip),
            child: BaseIcon(
              icon: Icons.info_outline_rounded,
              size: 18,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
