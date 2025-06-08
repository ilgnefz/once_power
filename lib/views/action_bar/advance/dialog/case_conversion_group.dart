import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/widgets/action_bar/dialog_option.dart';
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
    return DialogOption(
      title: '${S.of(context).convertLetters}: ',
      padding: const EdgeInsets.only(top: 4.0),
      alignment: WrapAlignment.spaceBetween,
      children: CaseType.values
          .map((e) => EasyRadio(
              label: e.label,
              value: e,
              groupValue: type,
              onChanged: (value) => typeChanged(value!)))
          .toList(),
    );
  }
}
