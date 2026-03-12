import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/common/checkbox.dart';

class DeleteTypeGroup extends StatefulWidget {
  const DeleteTypeGroup({
    super.key,
    required this.deleteTypes,
    required this.onChanged,
  });

  final List<DeleteType> deleteTypes;
  final void Function(DeleteType) onChanged;

  @override
  State<DeleteTypeGroup> createState() => _DeleteTypeGroupState();
}

class _DeleteTypeGroupState extends State<DeleteTypeGroup> {
  @override
  Widget build(BuildContext context) {
    return DialogOption(
      title: tr(AppL10n.advanceDeleteType),
      padding: const EdgeInsets.only(top: 4),
      spacing: 12,
      children: [
        EasyCheckbox(
          label: tr(AppL10n.advanceAll),
          checked: widget.deleteTypes.length == DeleteType.values.length,
          onChanged: (value) {
            widget.deleteTypes.clear();
            for (var element in DeleteType.values) {
              if (value!) {
                widget.deleteTypes.add(element);
              } else {
                widget.deleteTypes.remove(element);
              }
            }
            setState(() {});
          },
        ),
        ...DeleteType.values.map((e) {
          return EasyCheckbox(
            label: e.label,
            checked: widget.deleteTypes.contains(e),
            onChanged: (v) => widget.onChanged(e),
          );
        }),
      ],
    );
  }
}
