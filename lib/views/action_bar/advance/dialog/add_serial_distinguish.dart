import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/widgets/action_bar/dialog_option.dart';
import 'package:once_power/widgets/action_bar/easy_radio.dart';

class AddSerialDistinguish extends StatelessWidget {
  const AddSerialDistinguish({
    super.key,
    required this.type,
    required this.typeChanged,
  });

  final DistinguishType type;
  final Function(DistinguishType) typeChanged;

  @override
  Widget build(BuildContext context) {
    return DialogOption(
      title: '${S.of(context).serialDistinguish}: ',
      padding: const EdgeInsets.only(top: 4.0),
      alignment: WrapAlignment.spaceBetween,
      children: DistinguishType.values
          .map((e) => EasyRadio(
                label: e.label,
                value: e,
                groupValue: type,
                onChanged: (value) => typeChanged(value!),
              ))
          .toList(),
    );
  }
}
