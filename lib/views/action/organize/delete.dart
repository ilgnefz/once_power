import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/base/easy_elevated_btn.dart';

class DeleteGroup extends StatelessWidget {
  const DeleteGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyElevatedBtn(
            label: tr(AppL10n.organizeSelected),
            onPressed: () {},
          ),
          EasyElevatedBtn(label: tr(AppL10n.organizeEmpty), onPressed: () {}),
        ],
      ),
    );
  }
}
