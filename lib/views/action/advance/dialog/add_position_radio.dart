import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/widgets/action/dialog_option.dart';
import 'package:once_power/widgets/base/easy_radio.dart';
import 'package:once_power/widgets/common/digit_input.dart';

class AddPositionRadio extends StatelessWidget {
  const AddPositionRadio({
    super.key,
    required this.posIndex,
    required this.addPosition,
    required this.positionChanged,
    required this.posIndexChanged,
  });

  final int posIndex;
  final AddPosition addPosition;
  final Function(AddPosition) positionChanged;
  final Function(int) posIndexChanged;

  @override
  Widget build(BuildContext context) {
    return DialogOption(
      title: '${tr(AppL10n.advanceAddPosition)}: ',
      padding: EdgeInsets.only(top: 4.0),
      alignment: WrapAlignment.spaceBetween,
      children: [
        ...AddPosition.values.map(
          (e) => EasyRadio(
            label: e.label,
            value: e,
            groupValue: addPosition,
            onChanged: (value) => positionChanged(value!),
          ),
        ),
        SizedBox(
          width: 120,
          child: DigitInput(
            value: posIndex,
            unit: tr(AppL10n.advancePlace),
            min: 1,
            onChanged: posIndexChanged,
          ),
        ),
      ],
    );
  }
}
