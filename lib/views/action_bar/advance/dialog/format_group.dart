import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';

class FormatGroup extends StatelessWidget {
  const FormatGroup({
    super.key,
    required this.mode,
    required this.onChanged,
  });

  final ReplaceMode mode;
  final void Function(ReplaceMode) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${S.of(context).replaceMode}: '),
        Radio(
          groupValue: mode,
          value: ReplaceMode.normal,
          onChanged: (value) => onChanged(value!),
        ),
        Text(S.of(context).normal),
        Spacer(),
        Radio(
          groupValue: mode,
          value: ReplaceMode.format,
          onChanged: (value) => onChanged(value!),
        ),
        Text(S.of(context).format),
      ],
    );
  }
}
