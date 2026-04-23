import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/model/rule.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/checkbox.dart';
import 'package:once_power/widget/common/text_dropdown.dart';

final List<DateType> _dateTypes = [
  DateType.created,
  DateType.modified,
  DateType.accessed,
  DateType.exif,
];

class AutoGroup extends StatefulWidget {
  const AutoGroup({super.key});

  @override
  State<AutoGroup> createState() => _AutoGroupState();
}

class _AutoGroupState extends State<AutoGroup> {
  DateGroupInfo info = DateGroupInfo();

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: tr(AppL10n.menuAutoDate),
      content: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: .spaceAround,
        crossAxisAlignment: .center,
        children: [
          TextDropdown(
            items: _dateTypes
                .map(
                  (item) => DropdownItem(
                    key: ValueKey(item),
                    value: item,
                    height: AppNum.widgetHeight,
                    child: BaseText(item.label),
                  ),
                )
                .toList(),
            width: 112,
            // color: theme.popupMenuTheme.surfaceTintColor,
            value: info.type,
            onChanged: (value) => setState(() => info.type = value),
          ),
          EasyCheckbox(
            label: tr(AppL10n.menuAutoYear),
            checked: info.year,
            onChanged: (value) => setState(() => info.year = value!),
          ),
          EasyCheckbox(
            label: tr(AppL10n.menuAutoMonth),
            checked: info.month,
            onChanged: (value) => setState(() => info.month = value!),
          ),
          EasyCheckbox(
            label: tr(AppL10n.menuAutoDay),
            checked: info.day,
            onChanged: (value) => setState(() => info.day = value!),
          ),
          EasyCheckbox(
            label: tr(AppL10n.menuAutoWeek),
            checked: info.week,
            onChanged: (value) => setState(() => info.week = value!),
          ),
        ],
      ),
      autoPop: false,
      onOk: () {
        Navigator.of(context).pop(info);
      },
    );
  }
}
