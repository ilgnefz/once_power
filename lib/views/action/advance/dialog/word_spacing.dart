import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';

import 'dialog_base_input.dart';

class WordSpacing extends StatelessWidget {
  const WordSpacing({super.key, required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${tr(AppL10n.advanceWord)}: ',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Expanded(
          child: DialogBaseInput(
            value: value,
            enable: true,
            hintText: tr(AppL10n.advanceWordHint),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
