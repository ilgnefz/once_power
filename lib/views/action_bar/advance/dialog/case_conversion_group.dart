import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/widgets/action_bar/easy_radio.dart';

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
          child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: CaseType.values
                  .map((e) => EasyRadio(
                      label: e.label,
                      value: e,
                      groupValue: type,
                      onChanged: (value) => typeChanged(value!)))
                  .toList()),
        ),
      ],
    );
  }
}
