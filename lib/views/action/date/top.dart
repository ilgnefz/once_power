import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';

class DateTop extends StatelessWidget {
  const DateTop({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppNum.actionTop,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: AppNum.padding),
            child: Text(tr(AppL10n.dateTitle)),
          ),
          TextButton(child: Text('退出'), onPressed: () {}),
        ],
      ),
    );
  }
}
