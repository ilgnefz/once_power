import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/advance.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/action/number_input.dart';
import 'package:once_power/widget/base/radio.dart';

class MatchPositionGroup extends StatelessWidget {
  const MatchPositionGroup({
    super.key,
    required this.position,
    required this.onChanged,
    required this.front,
    required this.onFrontChanged,
    required this.behind,
    required this.onBehindChanged,
  });

  final MatchPosition position;
  final Function(MatchPosition) onChanged;
  final int front;
  final Function(int) onFrontChanged;
  final int behind;
  final Function(int) onBehindChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup(
      groupValue: position,
      onChanged: (value) => onChanged(value!),
      child: DialogItem(
        title: context.tr(AppL10n.inputPosition),
        spacing: AppNumber.space,
        runSpacing: AppNumber.spaceSmall,
        // alignment: .spaceBetween,
        children: MatchPosition.values.map((e) {
          return EasyRadio(
            label: e.label,
            value: e,
            trailing: e.isSelf
                ? null
                : SizedBox(
                    width: 108,
                    child: NumberInput(
                      value: e.isFront ? front : behind,
                      min: 1,
                      unit: tr(AppL10n.digit),
                      onChanged: e.isFront ? onFrontChanged : onBehindChanged,
                    ),
                  ),
          );
        }).toList(),
      ),
    );
  }
}
