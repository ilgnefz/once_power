import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/common/digit_input.dart';

class AddSerial extends StatelessWidget {
  const AddSerial({
    super.key,
    required this.digits,
    required this.onDigitChanged,
    required this.start,
    required this.onStartChanged,
  });

  final int digits;
  final void Function(int) onDigitChanged;
  final int start;
  final void Function(int) onStartChanged;

  @override
  Widget build(BuildContext context) {
    return DialogOption(
      title: tr(AppL10n.advanceSerial),
      padding: const .only(top: 4, right: 4),
      spacing: AppNum.spaceSmall,
      children: [
        DigitInput(
          width: 120,
          value: digits,
          unit: tr(AppL10n.renameDigits),
          min: 1,
          onChanged: onDigitChanged,
        ),
        DigitInput(
          width: 120,
          value: start,
          unit: tr(AppL10n.renameStart),
          onChanged: onStartChanged,
        ),
      ],
    );
  }
}
