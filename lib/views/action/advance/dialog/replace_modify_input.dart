import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/action/icon_box.dart';

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
      spacing: AppNum.spaceMedium,
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
        IconBox(
          icon: AppIcons.extension,
          tip: tr(AppL10n.advanceMatchExt),
          // placement: Placement.right,
          checked: matchExt,
          onPressed: onTap,
        ),
      ],
    );
  }
}
