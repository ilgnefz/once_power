import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/widgets/action/dialog_option.dart';
import 'package:once_power/widgets/base/easy_radio.dart';
import 'package:once_power/widgets/common/digit_input.dart';

class CommonPositionRadio extends StatelessWidget {
  const CommonPositionRadio({
    super.key,
    required this.location,
    required this.onChanged,
    required this.start,
    required this.end,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.front,
    required this.back,
    required this.onFrontChanged,
    required this.onBackChanged,
  });

  final MatchContent location;
  final Function(MatchContent) onChanged;
  final int front;
  final int back;
  final Function(int) onFrontChanged;
  final Function(int) onBackChanged;
  final int start;
  final int end;
  final Function(int) onStartChanged;
  final Function(int) onEndChanged;

  @override
  Widget build(BuildContext context) {
    return DialogOption(
      title: '${tr(AppL10n.advanceMatchPosition)}: ',
      padding: const EdgeInsets.only(top: 4.0),
      runSpacing: AppNum.spaceMedium,
      alignment: WrapAlignment.spaceBetween,
      children: MatchContent.values.map((e) {
        if (e.isPosition) {
          return EasyRadio(
            label: '',
            value: e,
            groupValue: location,
            onChanged: (value) => onChanged(value!),
            space: 0,
            trailing: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: DigitInput(
                    value: start,
                    unit: tr(AppL10n.advanceStart),
                    min: 1,
                    onChanged: onStartChanged,
                  ),
                ),
                const SizedBox(width: AppNum.spaceLarge),
                SizedBox(
                  width: 120,
                  child: DigitInput(
                    value: end,
                    unit: tr(AppL10n.advanceEnd),
                    min: 1,
                    onChanged: onEndChanged,
                  ),
                ),
              ],
            ),
          );
        }
        if (e.isFront) {
          return EasyRadio(
            label: e.label,
            value: e,
            groupValue: location,
            onChanged: (value) => onChanged(value!),
            trailing: SizedBox(
              width: 100,
              child: DigitInput(
                value: front,
                unit: tr(AppL10n.advancePlace),
                min: 1,
                onChanged: onFrontChanged,
              ),
            ),
          );
        }
        if (e.isBehind) {
          return EasyRadio(
            label: e.label,
            value: e,
            groupValue: location,
            onChanged: (value) => onChanged(value!),
            trailing: SizedBox(
              width: 100,
              child: DigitInput(
                value: back,
                unit: tr(AppL10n.advancePlace),
                min: 1,
                onChanged: onBackChanged,
              ),
            ),
          );
        }
        return EasyRadio(
          label: e.label,
          value: e,
          groupValue: location,
          onChanged: (value) => onChanged(value!),
        );
      }).toList(),
    );
  }
}
