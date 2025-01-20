import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';

class CaseConversionGroup extends StatelessWidget {
  const CaseConversionGroup({
    super.key,
    required this.type,
    required this.typeChanged,
  });

  final CaseType type;
  final Function(CaseType) typeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text('${S.of(context).convertLetters}: '),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Radio(
                    groupValue: type,
                    value: CaseType.noConversion,
                    onChanged: (value) => typeChanged(value!),
                  ),
                  Text(S.of(context).noConversion),
                  Spacer(),
                  Radio(
                    groupValue: type,
                    value: CaseType.toggleCase,
                    onChanged: (value) => typeChanged(value!),
                  ),
                  Text(S.of(context).toggleCase),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Radio(
                    groupValue: type,
                    value: CaseType.uppercase,
                    onChanged: (value) => typeChanged(value!),
                  ),
                  Text(S.of(context).uppercase),
                  Spacer(),
                  Radio(
                    groupValue: type,
                    value: CaseType.lowercase,
                    onChanged: (value) => typeChanged(value!),
                  ),
                  Text(S.of(context).lowercase),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
