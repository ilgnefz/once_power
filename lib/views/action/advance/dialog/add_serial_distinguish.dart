import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/widgets/action/dialog_option.dart';
import 'package:once_power/widgets/base/easy_radio.dart';

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
            ),
          )
          .toList(),
    );
  }
}
