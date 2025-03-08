import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/widgets/common/easy_text_dropdown.dart';

class FormatGroup extends StatelessWidget {
  const FormatGroup({
    super.key,
    required this.mode,
    required this.onChanged,
    required this.position,
    required this.onPositionChanged,
  });

  final ReplaceMode mode;
  final void Function(ReplaceMode) onChanged;
  final FillPosition position;
  final void Function(FillPosition) onPositionChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${S.of(context).replaceMode}: '),
        Radio(
          groupValue: mode,
          value: ReplaceMode.normal,
          onChanged: (value) => onChanged(value!),
        ),
        Text(S.of(context).normal),
        Spacer(),
        Radio(
          groupValue: mode,
          value: ReplaceMode.format,
          onChanged: (value) => onChanged(value!),
        ),
        Text(S.of(context).format),
        SizedBox(width: AppNum.largeG),
        EasyTextDropdown(
          items: FillPosition.values
              .map((item) => DropdownMenuItem(
                    key: ValueKey(item),
                    value: item,
                    child: Text(item.label),
                  ))
              .toList(),
          width: 100,
          value: position,
          onChanged: (value) => onPositionChanged(value!),
        ),
      ],
    );
  }
}
