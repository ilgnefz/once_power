import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/action_bar/digit_input.dart';

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
    return Row(
      children: [
        Text('${S.of(context).serialNumber}: '),
        const SizedBox(width: AppNum.smallG),
        SizedBox(
          width: 120,
          child: DigitInput(
            value: digits,
            label: S.of(context).digits,
            onChanged: onDigitsChanged,
          ),
        ),
        const SizedBox(width: AppNum.largeG),
        SizedBox(
          width: 120,
          child: DigitInput(
            value: start,
            label: S.of(context).start,
            onChanged: onStartChanged,
          ),
        ),
      ],
    );
  }
}
