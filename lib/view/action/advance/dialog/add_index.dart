import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/common/digit_input.dart';

class AddIndex extends StatelessWidget {
  const AddIndex({
    super.key,
    required this.width,
    required this.onWidthChanged,
    required this.start,
    required this.onStartChanged,
  });

  final int width;
  final void Function(int) onWidthChanged;
  final int start;
  final void Function(int) onStartChanged;

  @override
  Widget build(BuildContext context) {
    return DialogOption(
      title: tr(AppL10n.advanceIndex),
      padding: const .only(top: 4, right: 4),
      spacing: AppNum.spaceSmall,
      children: [
        DigitInput(
          width: 120,
          value: width,
          unit: tr(AppL10n.renameWidth),
          min: 1,
          onChanged: onWidthChanged,
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
