import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/views/action/add_group.dart';
import 'package:once_power/views/action/apply_group.dart';
import 'package:once_power/views/action/date/apply.dart';
import 'package:once_power/views/action/date/input.dart';
import 'package:once_power/views/action/date/title.dart';
import 'package:once_power/views/action/date/top.dart';

class DateView extends StatelessWidget {
  const DateView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppNum.action,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateTop(),
          DateTitle(
            checked: true,
            title: tr(AppL10n.eDateCreate),
            label: 'label',
          ),
          SizedBox(height: 6),
          TimeInput(),
          SizedBox(height: 6),
          DateTitle(
            checked: true,
            title: tr(AppL10n.eDateModify),
            label: 'label',
          ),
          SizedBox(height: 6),
          TimeInput(),
          SizedBox(height: 6),
          DateTitle(
            checked: true,
            title: tr(AppL10n.eDateAccess),
            label: 'label',
          ),
          SizedBox(height: 6),
          TimeInput(),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
            child: Text(
              tr(AppL10n.dateNote),
              style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
            ),
          ),
          Spacer(),
          AddGroup(),
          SizedBox(height: 6),
          ApplyGroup(slot: ApplyModify()),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
