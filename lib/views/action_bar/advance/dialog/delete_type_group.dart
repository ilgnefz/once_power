import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class DeleteTypeGroup extends StatelessWidget {
  const DeleteTypeGroup({
    super.key,
    required this.deleteTypes,
    required this.onChanged,
  });

  final List<DeleteType> deleteTypes;
  final void Function(DeleteType) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text('${S.of(context).deleteType}: '),
        ),
        Expanded(
          child: Wrap(
            spacing: 10,
            children: DeleteType.values.map((e) {
              return EasyCheckbox(
                mainAxisSize: MainAxisSize.min,
                label: e.label,
                sideWidth: 1.5,
                checked: deleteTypes.contains(e),
                onChanged: (v) => onChanged(e),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
