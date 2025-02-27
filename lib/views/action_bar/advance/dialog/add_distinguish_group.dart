import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';

class AddSerialDistinguish extends StatelessWidget {
  const AddSerialDistinguish({
    super.key,
    required this.type,
    required this.typeChanged,
  });

  final DistinguishType type;
  final Function(DistinguishType) typeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text('${S.of(context).serialDistinguish}: '),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Radio(
                    groupValue: type,
                    value: DistinguishType.none,
                    onChanged: (value) => typeChanged(value!),
                  ),
                  Text(DistinguishType.none.value),
                  Spacer(),
                  Radio(
                    groupValue: type,
                    value: DistinguishType.file,
                    onChanged: (value) => typeChanged(value!),
                  ),
                  Text(DistinguishType.file.value),
                ],
              ),
              Row(
                children: [
                  Radio(
                    groupValue: type,
                    value: DistinguishType.extension,
                    onChanged: (value) => typeChanged(value!),
                  ),
                  Text(DistinguishType.extension.value),
                  Spacer(),
                  Radio(
                    groupValue: type,
                    value: DistinguishType.folder,
                    onChanged: (value) => typeChanged(value!),
                  ),
                  Text(DistinguishType.folder.value),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
