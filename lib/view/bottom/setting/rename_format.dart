import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/common/digit_input.dart';
import 'package:once_power/widget/common/input_field.dart';
import 'package:once_power/widget/common/one_line_text.dart';

class RenameFormat extends StatelessWidget {
  const RenameFormat({
    super.key,
    required this.prefix,
    required this.width,
    required this.onPrefixChanged,
    required this.onWidthChanged,
  });

  final String prefix;
  final int width;
  final void Function(String) onPrefixChanged;
  final void Function(int) onWidthChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OneLineText(tr(AppL10n.bottomAutoRenameFormat)),
        Row(
          children: [
            SizedBox(
              width: 80,
              child: InputField(
                text: prefix,
                hintText: tr(AppL10n.advanceAddPrefix),
                onChanged: onPrefixChanged,
              ),
            ),
            SizedBox(width: AppNum.spaceSmall),
            DigitInput(
              width: 100,
              value: width,
              unit: tr(AppL10n.advancePCount),
              onChanged: onWidthChanged,
            ),
            SizedBox(width: AppNum.spaceMedium),
          ],
        ),
      ],
    );
  }
}
