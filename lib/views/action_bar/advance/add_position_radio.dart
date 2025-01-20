import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';

class AddPositionRadio extends StatelessWidget {
  const AddPositionRadio({
    super.key,
    required this.position,
    required this.positionChanged,
  });

  final AddPosition position;
  final Function(AddPosition) positionChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${S.of(context).addPosition}: '),
        Radio(
          groupValue: position,
          value: AddPosition.before,
          onChanged: (value) => positionChanged(value!),
        ),
        Text(S.of(context).addBefore),
        Spacer(),
        Radio(
          groupValue: position,
          value: AddPosition.after,
          onChanged: (value) => positionChanged(value!),
        ),
        Text(S.of(context).addAfter),
      ],
    );
  }
}
