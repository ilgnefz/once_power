import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/widgets/action_bar/digit_input.dart';
import 'package:once_power/widgets/action_bar/easy_radio.dart';

class AddTypeRadio extends StatelessWidget {
  const AddTypeRadio({
    super.key,
    required this.type,
    required this.typeChanged,
    required this.randomLenChange,
  });

  final AddType type;
  final void Function(AddType) typeChanged;
  final void Function(int) randomLenChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text('${S.of(context).addType}: '),
        ),
        Expanded(
          child: Wrap(
            spacing: 43,
            runSpacing: AppNum.mediumG,
            children: [
              ...AddType.values.map((e) {
                return EasyRadio(
                  label: e.label,
                  value: e,
                  groupValue: type,
                  onChanged: (value) => typeChanged(value!),
                  trailing: e.isRandom
                      ? Container(
                          width: 120,
                          margin: EdgeInsets.only(left: AppNum.mediumG),
                          child: DigitInput(
                            value: 1,
                            label: S.of(context).digits,
                            min: 1,
                            onChanged: randomLenChange,
                          ),
                        )
                      : null,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
