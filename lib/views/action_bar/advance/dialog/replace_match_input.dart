import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/action_bar/icon_box.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

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
    required this.onTap,
  });

  final String value;
  final bool enable;
  final String hintText;
  final bool useRegex;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String) onChanged;
  final void Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      spacing: AppNum.mediumG,
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
          AppIcons.regex,
          tip: S.of(context).regexDesc,
          placement: Placement.right,
          selected: useRegex,
          onTap: onTap,
        ),
      ],
    );
  }
}
