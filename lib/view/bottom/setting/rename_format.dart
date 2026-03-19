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
    required this.suffix,
    required this.onPrefixChanged,
    required this.onWidthChanged,
    required this.onSuffixChanged,
  });

  final String prefix;
  final int width;
  final String suffix;
  final void Function(String) onPrefixChanged;
  final void Function(int) onWidthChanged;
  final void Function(String) onSuffixChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OneLineText(tr(AppL10n.settingAutoRenameFormat)),
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
              min: 1,
              unit: tr(AppL10n.advancePCount),
              onChanged: onWidthChanged,
            ),
            SizedBox(width: AppNum.spaceSmall),
            SizedBox(
              width: 80,
              child: InputField(
                text: suffix,
                hintText: tr(AppL10n.advanceAddSuffix),
                onChanged: onSuffixChanged,
              ),
            ),
            SizedBox(width: AppNum.spaceMedium),
          ],
        ),
      ],
    );
  }
}
