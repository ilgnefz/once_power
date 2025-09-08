import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/widgets/base/easy_radio.dart';
import 'package:once_power/widgets/common/digit_input.dart';

class AddPositionRadio extends StatelessWidget {
  const AddPositionRadio({
    super.key,
    required this.posIndex,
    required this.addPosition,
    required this.positionChanged,
    required this.posIndexChanged,
  });

  final int posIndex;
  final AddPosition addPosition;
  final Function(AddPosition) positionChanged;
  final Function(int) posIndexChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${tr(AppL10n.advanceAddPosition)}: '),
        EasyRadio(
          label: tr(AppL10n.advanceAddBefore),
          value: AddPosition.before,
          groupValue: addPosition,
          onChanged: (value) => positionChanged(value!),
        ),
        Spacer(),
        EasyRadio(
          label: tr(AppL10n.advanceAddAfter),
          value: AddPosition.after,
          groupValue: addPosition,
          onChanged: (value) => positionChanged(value!),
        ),
        Spacer(),
        SizedBox(
          width: 120,
          child: DigitInput(
            value: posIndex,
            unit: tr(AppL10n.advancePlace),
            min: 1,
            onChanged: posIndexChanged,
          ),
        ),
      ],
    );
  }
}
