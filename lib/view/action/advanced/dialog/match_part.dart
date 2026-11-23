import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/action/number_input.dart';

class MatchPartGroup extends StatelessWidget {
  const MatchPartGroup({
    super.key,
    required this.selected,
    required this.start,
    required this.digit,
    required this.onStartChanged,
    required this.onDigitChanged,
  });

  final bool selected;
  final int start;
  final int digit;
  final void Function(int) onStartChanged;
  final void Function(int) onDigitChanged;

  @override
  Widget build(BuildContext context) {
    return SelectedBox(
      selected: selected,
      child: DialogItem(
        title: context.tr(AppL10n.matchPart),
        children: [
          const SizedBox(width: AppNumber.spaceSmall),
          SizedBox(
            width: 108,
            child: NumberInput(
              value: start,
              min: 1,
              unit: context.tr(AppL10n.start),
              onChanged: onStartChanged,
            ),
          ),
          const SizedBox(width: AppNumber.spaceSmall),
          SizedBox(
            width: 108,
            child: NumberInput(
              value: digit,
              min: 1,
              unit: context.tr(AppL10n.digit),
              onChanged: onDigitChanged,
            ),
          ),
        ],
      ),
    );
  }
}
