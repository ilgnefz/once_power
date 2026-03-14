import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/checkbox.dart';
import 'package:once_power/widget/common/digit_input.dart';
import 'package:once_power/widget/common/radio.dart';

class MatchPositionGroup extends StatelessWidget {
  const MatchPositionGroup({
    super.key,
    required this.position,
    required this.onChanged,
    required this.front,
    required this.onFrontChanged,
    required this.behind,
    required this.onBehindChanged,
  });

  final MatchPosition position;
  final Function(MatchPosition) onChanged;
  final int front;
  final Function(int) onFrontChanged;
  final int behind;
  final Function(int) onBehindChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup(
      groupValue: position,
      onChanged: (value) => onChanged(value!),
      child: DialogOption(
        title: tr(AppL10n.advanceMatchPosition),
        padding: .only(top: AppNum.spaceSmall),
        spacing: AppNum.spaceLarge,
        runSpacing: AppNum.spaceSmall,
        // alignment: .spaceBetween,
        children: MatchPosition.values.map((e) {
          return EasyRadio(
            label: e.label,
            value: e,
            trailing: e.isSelf
                ? null
                : DigitInput(
                    width: 108,
                    value: e.isFront ? front : behind,
                    min: 1,
                    unit: tr(AppL10n.advanceCount),
                    onChanged: e.isFront ? onFrontChanged : onBehindChanged,
                  ),
          );
        }).toList(),
      ),
    );
  }
}
