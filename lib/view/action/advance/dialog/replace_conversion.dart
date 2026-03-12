import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/common/radio.dart';

class ReplaceConversion extends StatelessWidget {
  const ReplaceConversion({
    super.key,
    required this.type,
    required this.onChanged,
  });

  final ConvertType type;
  final void Function(ConvertType) onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<ConvertType>(
      groupValue: type,
      onChanged: (value) => onChanged(value!),
      child: DialogOption(
        title: tr(AppL10n.advanceConvertLetters),
        padding: const .only(top: 4.0),
        children: ConvertType.values
            .map((e) => EasyRadio(label: e.label, value: e))
            .toList(),
      ),
    );
  }
}
