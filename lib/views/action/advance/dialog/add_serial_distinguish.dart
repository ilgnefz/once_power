import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/widgets/action/dialog_option.dart';
import 'package:once_power/widgets/base/easy_radio.dart';
import 'package:once_power/widgets/common/dropdown_text.dart';

class AddSerialDistinguish extends StatelessWidget {
  const AddSerialDistinguish({
    super.key,
    required this.type,
    required this.dateType,
    required this.typeChanged,
    required this.dateTypeChanged,
  });

  final DistinguishType type;
  final DateType dateType;
  final Function(DistinguishType) typeChanged;
  final Function(DateType?) dateTypeChanged;

  @override
  Widget build(BuildContext context) {
    return DialogOption(
      title: '${tr(AppL10n.advanceSerialDistinguish)}: ',
      padding: const EdgeInsets.only(top: 4.0),
      alignment: WrapAlignment.spaceBetween,
      children: DistinguishType.values
          .map(
            (e) => EasyRadio(
              label: e.label,
              value: e,
              groupValue: type,
              onChanged: (value) => typeChanged(value!),
              trailing: () {
                if (e.isDate) {
                  final ThemeData theme = Theme.of(context);
                  return TextDropdown(
                    items: DateType.values
                        .map(
                          (item) => DropdownMenuItem(
                            key: ValueKey(item),
                            value: item,
                            child: Text(item.label,
                                style: theme.dropdownMenuTheme.textStyle),
                          ),
                        )
                        .toList(),
                    width: 104,
                    color: theme.popupMenuTheme.surfaceTintColor,
                    value: dateType,
                    onChanged: dateTypeChanged,
                  );
                }
              }(),
            ),
          )
          .toList(),
    );
  }
}
