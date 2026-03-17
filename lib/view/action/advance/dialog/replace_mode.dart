import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/view/action/advance/dialog/mode_position.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/radio.dart';
import 'package:once_power/widget/common/text_dropdown.dart';

class ReplaceModeGroup extends StatelessWidget {
  const ReplaceModeGroup({
    super.key,
    required this.mode,
    required this.onChanged,
    required this.fillPosition,
    required this.onFillChanged,
    required this.start,
    required this.end,
    required this.onStartChanged,
    required this.onEndChanged,
  });

  final ReplaceMode mode;
  final void Function(ReplaceMode value) onChanged;
  final FillPosition fillPosition;
  final void Function(FillPosition value) onFillChanged;
  final int start;
  final int end;
  final Function(int) onStartChanged;
  final Function(int) onEndChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<ReplaceMode>(
      groupValue: mode,
      onChanged: (value) => onChanged(value!),
      child: DialogOption(
        title: tr(AppL10n.advanceReplaceMode),
        padding: const .only(top: 4.0),
        // alignment: .spaceBetween,
        spacing: 24,
        runSpacing: AppNum.spaceMedium,
        children: ReplaceMode.values.map((e) {
          switch (e) {
            case ReplaceMode.format:
              return EasyRadio(
                label: e.label,
                value: e,
                trailing: TextDropdown<FillPosition>(
                  items: FillPosition.values
                      .map(
                        (item) => DropdownItem(
                          key: ValueKey(item),
                          value: item,
                          height: AppNum.dropdownMenu,
                          child: BaseText(item.label),
                        ),
                      )
                      .toList(),
                  width: 114,
                  value: fillPosition,
                  onChanged: onFillChanged,
                ),
              );
            case ReplaceMode.position:
              return ModePosition<ReplaceMode>(
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
