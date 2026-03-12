import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';

class DeleteExtensionSwitch extends StatelessWidget {
  const DeleteExtensionSwitch({super.key, required this.value, this.onChanged});

  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppNum.paddingMedium,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${tr(AppL10n.advanceDeleteExt)}:',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 24,
          child: FittedBox(
            child: Switch(
              value: value,
              onChanged: onChanged,
              mouseCursor: SystemMouseCursors.click,
              // trackOutlineColor: .all(Colors.transparent),
            ),
          ),
        ),
      ],
    );
  }
}
