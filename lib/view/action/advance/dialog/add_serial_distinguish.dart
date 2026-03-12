import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/radio.dart';
import 'package:once_power/widget/common/text_dropdown.dart';

class AddSerialDistinguish extends StatelessWidget {
  const AddSerialDistinguish({
    super.key,
    required this.type,
    required this.onChanged,
    required this.dateType,
    required this.onDateTypeChange,
  });

  final DistinguishType type;
  final void Function(DistinguishType value) onChanged;
  final DateType dateType;
  final void Function(DateType value) onDateTypeChange;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<DistinguishType>(
      groupValue: type,
      onChanged: (value) => onChanged(value!),
      child: DialogOption(
        title: tr(AppL10n.advanceSerialDistinguish),
        padding: const .only(top: 4.0),
        alignment: .spaceBetween,
        children: DistinguishType.values
            .map(
              (e) => EasyRadio(
                label: e.label,
                value: e,
                trailing: e.isDate
                    ? TextDropdown<DateType>(
                        items: DateType.values
                            .map(
                              (item) => DropdownItem(
                                key: ValueKey(item),
                                value: item,
                                height: AppNum.dropdownMenu,
                                child: BaseText(item.label),
                              ),
                            )
                            .toList(),
                        value: dateType,
                        width: 100,
                        onChanged: onDateTypeChange,
                      )
                    : null,
              ),
            )
            .toList(),
      ),
    );
  }
}
