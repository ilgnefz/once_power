import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/action/dialog_option.dart';
import 'package:once_power/widgets/common/digit_input.dart';

class NumInputGroup extends StatelessWidget {
  const NumInputGroup({
    super.key,
    required this.digits,
    required this.start,
    required this.onDigitsChanged,
    required this.onStartChanged,
  });

  final int digits;
  final int start;
  final void Function(int) onDigitsChanged;
  final void Function(int) onStartChanged;

  @override
  Widget build(BuildContext context) {
    return DialogOption(
        title: '${tr(AppL10n.advanceSerial)}: ',
        padding:
            EdgeInsets.only(top: AppNum.spaceSmall, right: AppNum.spaceSmall),
        children: [
          SizedBox(
            width: 120,
            child: DigitInput(
              value: digits,
              unit: tr(AppL10n.advanceDigits),
              onChanged: onDigitsChanged,
            ),
          ),
          const SizedBox(width: AppNum.spaceLarge),
          SizedBox(
            width: 120,
            child: DigitInput(
              value: start,
              unit: tr(AppL10n.advanceStart),
              onChanged: onStartChanged,
            ),
          ),
        ]);
  }
}
