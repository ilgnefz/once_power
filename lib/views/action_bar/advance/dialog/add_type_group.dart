import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';

class AddTypeRadio extends StatelessWidget {
  const AddTypeRadio({
    super.key,
    required this.type,
    required this.typeChanged,
  });

  final AddType type;
  final Function(AddType) typeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${S.of(context).addType}: '),
        Radio(
          groupValue: type,
          value: AddType.text,
          onChanged: (value) => typeChanged(value!),
        ),
        Text(S.of(context).text),
        Spacer(),
        Radio(
          groupValue: type,
          value: AddType.serialNumber,
          onChanged: (value) => typeChanged(value!),
        ),
        Text(S.of(context).serialNumber),
        Spacer(),
        Radio(
          groupValue: type,
          value: AddType.parentsName,
          onChanged: (value) => typeChanged(value!),
        ),
        Text(S.of(context).parentsName),
      ],
    );
  }
}
