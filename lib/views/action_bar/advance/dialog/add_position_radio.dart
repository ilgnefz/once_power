import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';

import 'advance_digit_input.dart';

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
        Text('${S.of(context).addPosition}: '),
        Radio(
          groupValue: addPosition,
          value: AddPosition.before,
          onChanged: (value) => positionChanged(value!),
        ),
        Text(S.of(context).addBefore),
        Spacer(),
        Radio(
          groupValue: addPosition,
          value: AddPosition.after,
          onChanged: (value) => positionChanged(value!),
        ),
        Text(S.of(context).addAfter),
        Spacer(),
        Radio(
          groupValue: addPosition,
          value: AddPosition.position,
          onChanged: (value) => positionChanged(value!),
        ),
        SizedBox(
          width: 100,
          child: AdvanceDigitInput(
            value: posIndex,
            label: '',
            min: 1,
            onChanged: posIndexChanged,
          ),
        ),
      ],
    );
  }
}
