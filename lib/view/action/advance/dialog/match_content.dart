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
    required this.front,
    required this.onFrontChanged,
    required this.behind,
    required this.onBehindChanged,
    required this.start,
    required this.end,
    required this.onStartChanged,
    required this.onEndChanged,
  });

  final MatchContent content;
  final void Function(MatchContent) onChanged;
  final int number;
  final Function(int) onNumberChanged;
  final int front;
  final Function(int) onFrontChanged;
  final int behind;
  final Function(int) onBehindChanged;
  final int start;
  final int end;
  final Function(int) onStartChanged;
  final Function(int) onEndChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<MatchContent>(
      groupValue: content,
      onChanged: (value) => onChanged(value!),
      child: DialogOption(
        title: tr(AppL10n.advanceMatchContent),
        padding: .only(top: AppNum.spaceSmall),
        spacing: AppNum.spaceMedium,
        runSpacing: AppNum.spaceMedium,
        alignment: WrapAlignment.spaceBetween,
        children: MatchContent.values.map((e) {
          switch (e) {
            case MatchContent.number:
              return EasyRadio(
                label: e.label,
                value: e,
                trailing: DigitInput(
                  width: 100,
                  value: number,
                  min: 1,
                  unit: tr(AppL10n.advancePlace),
                  onChanged: onNumberChanged,
                ),
              );
            case MatchContent.front:
              return EasyRadio(
                label: e.label,
                value: e,
                trailing: DigitInput(
                  width: 100,
                  value: front,
                  min: 1,
                  unit: tr(AppL10n.advancePlace),
                  onChanged: onFrontChanged,
                ),
              );
            case MatchContent.behind:
              return EasyRadio(
                label: e.label,
                value: e,
                trailing: DigitInput(
                  width: 100,
                  value: behind,
                  min: 1,
                  unit: tr(AppL10n.advancePlace),
                  onChanged: onBehindChanged,
                ),
              );
            case MatchContent.position:
              return EasyRadio(
                label: e.label,
                value: e,
                space: 0,
                trailing: Row(
                  spacing: AppNum.spaceSmall,
                  children: [
                    DigitInput(
                      width: 108,
                      value: start,
                      min: 1,
                      unit: tr(AppL10n.advanceStart),
                      onChanged: onStartChanged,
                    ),
                    DigitInput(
                      width: 108,
                      value: end,
                      min: 1,
                      unit: tr(AppL10n.advanceEnd),
                      onChanged: onEndChanged,
                    ),
                  ],
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
