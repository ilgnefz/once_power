import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/action_bar/icon_box.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

import 'dialog_base_input.dart';

class ReplaceModifyInput extends ConsumerWidget {
  const ReplaceModifyInput({
    super.key,
    required this.value,
    required this.enable,
    required this.hintText,
    required this.matchExt,
    required this.onChanged,
    required this.onTap,
  });

  final String value;
  final bool enable;
  final String hintText;
  final bool matchExt;
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
            onChanged: onChanged,
          ),
        ),
        Material(
          child: IconBox(
            AppIcons.extension,
            tip: S.of(context).matchExtDesc,
            placement: Placement.right,
            selected: matchExt,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
