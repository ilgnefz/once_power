import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/add.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/action/number_input.dart';
import 'package:once_power/widget/base/radio.dart';
import 'package:once_power/widget/base/text.dart';

class AddPositionGroup extends StatelessWidget {
  const AddPositionGroup({
    super.key,
    required this.position,
    required this.onChanged,
    required this.positionIndex,
    required this.onIndexChanged,
  });

  final AddPosition position;
  final void Function(AddPosition) onChanged;
  final int positionIndex;
  final void Function(int) onIndexChanged;

  @override
  Widget build(BuildContext context) {
    return DialogItem(
      title: context.tr(AppL10n.addPosition),
      alignment: .spaceBetween,
      children: [
        RadioGroup<AddPosition>(
          groupValue: position,
          onChanged: (value) => onChanged(value!),
          child: Row(
            mainAxisSize: .min,
            spacing: AppNumber.spaceMedium,
            children: AddPosition.values
                .map((e) => EasyRadio(label: e.label, value: e))
                .toList(),
          ),
        ),
        SizedBox(
          width: 132,
          child: Row(
            spacing: AppNumber.spaceSmall,
            children: [
              BaseText(context.tr(AppL10n.ordinal)),
              Expanded(
                child: NumberInput(
                  value: positionIndex,
                  unit: tr(AppL10n.ordinalUnit),
                  min: 1,
                  onChanged: onIndexChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
