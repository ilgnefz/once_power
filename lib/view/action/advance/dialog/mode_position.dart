import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/common/digit_input.dart';
import 'package:once_power/widget/common/radio.dart';

class ModePosition<T> extends StatelessWidget {
  const ModePosition({
    super.key,
    required this.label,
    required this.value,
    required this.start,
    required this.onStartChanged,
    required this.end,
    required this.onEndChanged,
  });

  final String label;
  final T value;
  final int start;
  final void Function(int) onStartChanged;
  final int end;
  final void Function(int) onEndChanged;

  @override
  Widget build(BuildContext context) {
    return EasyRadio(
      label: label,
      value: value,
      space: 0,
      trailing: Row(
        spacing: AppNum.spaceSmall,
        children: [
          DigitInput(
            width: 108,
            value: start,
            min: 1,
            unit: tr(AppL10n.renameStart),
            onChanged: onStartChanged,
          ),
          DigitInput(
            width: 108,
            value: end,
            min: 1,
            unit: tr(AppL10n.advanceCount),
            onChanged: onEndChanged,
          ),
        ],
      ),
    );
  }
}
