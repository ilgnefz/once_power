import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';

import 'dialog_base_input.dart';

class WordSpacing extends StatelessWidget {
  const WordSpacing({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${S.of(context).wordSpacing}: '),
        Expanded(
          child: DialogBaseInput(
            value: value,
            enable: true,
            hintText: S.of(context).wordSpacingHint,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
