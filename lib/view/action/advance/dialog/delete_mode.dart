import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/view/action/advance/dialog/mode_position.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/common/radio.dart';

class DeleteModeGroup extends StatelessWidget {
  const DeleteModeGroup({
    super.key,
    required this.mode,
    required this.onChanged,
    required this.start,
    required this.end,
    required this.onStartChanged,
    required this.onEndChanged,
  });

  final DeleteMode mode;
  final void Function(DeleteMode mode) onChanged;
  final int start;
  final int end;
  final Function(int) onStartChanged;
  final Function(int) onEndChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<DeleteMode>(
      groupValue: mode,
      onChanged: (value) => onChanged(value!),
      child: DialogOption(
        title: tr(AppL10n.advanceDeleteMode),
        padding: const .only(top: 4),
        alignment: .spaceBetween,
        children: DeleteMode.values.map((e) {
          switch (e) {
            case DeleteMode.position:
              return ModePosition<DeleteMode>(
                label: e.label,
                value: e,
                start: start,
                onStartChanged: onStartChanged,
                end: end,
                onEndChanged: onEndChanged,
              );
            default:
              return EasyRadio(label: e.label, value: e);
          }
        }).toList(),
      ),
    );
  }
}
