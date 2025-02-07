import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';

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
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: deleteTypes.contains(e),
                    onChanged: (v) => onChanged(e),
                  ),
                  Text(e.value),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
