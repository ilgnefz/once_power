import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class TimeInput extends StatelessWidget {
  const TimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: BaseInput(
        hintText: tr(AppL10n.dateHint),
        trailing: ClickIcon(svg: AppIcons.date, onPressed: () {}),
      ),
    );
  }
}
