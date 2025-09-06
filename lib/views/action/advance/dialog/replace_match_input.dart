import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/action/icon_box.dart';

import 'dialog_base_input.dart';

class ReplaceMatchInput extends ConsumerWidget {
  const ReplaceMatchInput({
    super.key,
    required this.value,
    required this.enable,
    required this.hintText,
    required this.useRegex,
    required this.inputFormatters,
    required this.onChanged,
    required this.onPressed,
  });

  final String value;
  final bool enable;
  final String hintText;
  final bool useRegex;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String) onChanged;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      spacing: AppNum.spaceMedium,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: DialogBaseInput(
            value: value,
            enable: enable,
            hintText: hintText,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
          ),
        ),
        IconBox(
          icon: AppIcons.regex,
          tip: tr(AppL10n.advanceRegex),
          // placement: Placement.right,
          checked: useRegex,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
