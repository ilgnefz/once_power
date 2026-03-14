import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/common/checkbox.dart';

class DeleteTypeGroup extends StatelessWidget {
  const DeleteTypeGroup({
    super.key,
    required this.deleteTypes,
    required this.onChanged,
    required this.onAllChanged,
  });

  final List<DeleteType> deleteTypes;
  final void Function(DeleteType) onChanged;
  final void Function(bool) onAllChanged;

  @override
  Widget build(BuildContext context) {
    return DialogOption(
      title: tr(AppL10n.advanceDeleteType),
      padding: const EdgeInsets.only(top: 4),
      spacing: AppNum.spaceLarge,
      children: [
        EasyCheckbox(
          label: tr(AppL10n.advanceAll),
          checked: deleteTypes.length == DeleteType.values.length,
          onChanged: (value) => onAllChanged(value!),
        ),
        ...DeleteType.values.map((e) {
          return EasyCheckbox(
            label: e.label,
            checked: deleteTypes.contains(e),
            onChanged: (v) => onChanged(e),
          );
        }),
      ],
    );
  }
}
