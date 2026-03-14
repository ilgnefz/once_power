import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/common/digit_input.dart';
import 'package:once_power/widget/common/radio.dart';

class MatchContentGroup extends StatelessWidget {
  const MatchContentGroup({
    super.key,
    required this.content,
    required this.onChanged,
    required this.number,
    required this.onNumberChanged,
  });

  final MatchContent content;
  final void Function(MatchContent) onChanged;
  final int number;
  final Function(int) onNumberChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<MatchContent>(
      groupValue: content,
      onChanged: (value) => onChanged(value!),
      child: DialogOption(
        title: tr(AppL10n.advanceMatchContent),
        padding: .only(top: AppNum.spaceSmall),
        spacing: AppNum.spaceLarge,
        children: MatchContent.values.map((e) {
          switch (e) {
            case MatchContent.number:
              return EasyRadio(
                label: e.label,
                value: e,
                trailing: DigitInput(
                  width: 120,
                  value: number,
                  min: 1,
                  unit: tr(AppL10n.advanceGe),
                  onChanged: onNumberChanged,
                ),
              );
            default:
              return EasyRadio(label: e.label, value: e);
          }
        }).toList(),
      ),
    );
  }
}
