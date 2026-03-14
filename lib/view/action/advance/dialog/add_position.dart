import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/common/digit_input.dart';
import 'package:once_power/widget/common/radio.dart';

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
    return DialogOption(
      title: tr(AppL10n.advanceAddPosition),
      padding: const .only(top: 4.0),
      alignment: .spaceBetween,
      children: [
        RadioGroup<AddPosition>(
          groupValue: position,
          onChanged: (value) => onChanged(value!),
          child: Row(
            mainAxisSize: .min,
            spacing: AppNum.spaceMedium,
            children: AddPosition.values
                .map((e) => EasyRadio(label: e.label, value: e))
                .toList(),
          ),
        ),
        DigitInput(
          width: 120,
          value: positionIndex,
          unit: tr(AppL10n.advancePCount),
          min: 1,
          onChanged: onIndexChanged,
        ),
      ],
    );
  }
}
