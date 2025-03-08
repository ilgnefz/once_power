import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';

class DeleteExtensionSwitch extends StatelessWidget {
  const DeleteExtensionSwitch({super.key, required this.value, this.onChanged});

  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppNum.inputP,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${S.of(context).deleteExtension}:'),
        SizedBox(
          height: 24,
          child: FittedBox(
            child: Switch(value: value, onChanged: onChanged),
          ),
        ),
      ],
    );
  }
}
