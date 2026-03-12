import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/advance.dart';
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
  });

  final ReplaceMode mode;
  final void Function(ReplaceMode value) onChanged;
  final FillPosition fillPosition;
  final void Function(FillPosition value) onFillChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<ReplaceMode>(
      groupValue: mode,
      onChanged: (value) => onChanged(value!),
      child: DialogOption(
        title: tr(AppL10n.advanceReplaceMode),
        padding: const .only(top: 4.0),
        alignment: .spaceBetween,
        children: ReplaceMode.values.map((e) {
          return EasyRadio(
            label: e.label,
            value: e,
            trailing: e.isFormat
                ? TextDropdown<FillPosition>(
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
                    width: 112,
                    value: fillPosition,
                    onChanged: onFillChanged,
                  )
                : null,
          );
        }).toList(),
      ),
    );
  }
}
