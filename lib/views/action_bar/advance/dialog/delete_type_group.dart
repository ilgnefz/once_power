import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('${S.of(context).deleteType}: '),
        ),
        Expanded(
          child: Wrap(
            spacing: 10,
            children: [
              ...DeleteType.values.map((e) {
                return EasyCheckbox(
                  mainAxisSize: MainAxisSize.min,
                  label: e.label,
                  sideWidth: 1.5,
                  checked: widget.deleteTypes.contains(e),
                  onChanged: (v) => widget.onChanged(e),
                );
              }),
              EasyCheckbox(
                mainAxisSize: MainAxisSize.min,
                label: S.of(context).all,
                sideWidth: 1.5,
                checked: widget.deleteTypes.length == DeleteType.values.length,
                onChanged: (v) {
                  widget.deleteTypes.clear();
                  for (var element in DeleteType.values) {
                    if (v!) {
                      widget.deleteTypes.add(element);
                    } else {
                      widget.deleteTypes.remove(element);
                    }
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
