import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/widgets/action/dialog_option.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';

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
      title: '${tr(AppL10n.advanceDeleteType)}: ',
      padding: const EdgeInsets.only(top: 4),
      spacing: 10,
      children: [
        EasyCheckbox(
          // mainAxisSize: MainAxisSize.min,
          label: tr(AppL10n.advanceAll),
          // sideWidth: 1.5,
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
