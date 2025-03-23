import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/models/two_re_enum.dart';
import 'package:once_power/widgets/action_bar/digit_input.dart';
import 'package:once_power/widgets/action_bar/easy_radio.dart';
import 'package:once_power/widgets/common/easy_text_dropdown.dart';

class AddTypeRadio extends StatelessWidget {
  const AddTypeRadio({
    super.key,
    required this.type,
    required this.len,
    required this.date,
    required this.typeChanged,
    required this.randomLenChange,
    required this.dateChange,
  });

  final AddType type;
  final int len;
  final DateType date;
  final void Function(AddType) typeChanged;
  final void Function(int) randomLenChange;
  final void Function(DateType?) dateChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text('${S.of(context).addType}: '),
        ),
        Expanded(
          child: Wrap(
            runSpacing: AppNum.smallG,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              ...AddType.values.map((e) {
                return EasyRadio(
                  label: e.label,
                  value: e,
                  groupValue: type,
                  onChanged: (value) => typeChanged(value!),
                  space: 0,
                  trailing: e.isRandom
                      ? Container(
                          width: 104,
                          margin: EdgeInsets.only(left: AppNum.mediumG),
                          child: DigitInput(
                            value: len,
                            label: S.of(context).digits,
                            min: 1,
                            onChanged: randomLenChange,
                          ),
                        )
                      : e.isDate
                          ? Consumer(
                              builder: (_, ref, __) => EasyTextDropdown(
                                items: DateType.values
                                    .map((item) => DropdownMenuItem(
                                          key: ValueKey(item),
                                          value: item,
                                          child: Text(item.label),
                                        ))
                                    .toList(),
                                width: 102,
                                color: Colors.grey[100],
                                value: date,
                                onChanged: dateChange,
                              ),
                            )
                          : null,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
