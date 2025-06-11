import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/action_bar/icon_box.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

import 'dialog_base_input.dart';

class DeleteMatchInput extends ConsumerWidget {
  const DeleteMatchInput({
    super.key,
    required this.value,
    required this.enable,
    required this.useRegex,
    required this.onChanged,
    required this.onTap,
  });

  final String value;
  final bool enable;
  final bool useRegex;
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
            hintText: S.of(context).deleteInputHint,
            onChanged: onChanged,
          ),
        ),
        Material(
          child: IconBox(
            AppIcons.regex,
            tip: S.of(context).regexDesc,
            placement: Placement.right,
            selected: useRegex,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
