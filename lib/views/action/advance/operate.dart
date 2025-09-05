import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/views/action/advance/preset/preset.dart';
import 'package:once_power/widgets/base/easy_btn.dart';

class OperateGroup extends StatelessWidget {
  const OperateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: Row(
        spacing: 4,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          EasyBtn(label: tr(AppL10n.advanceDelete), onPressed: () {}),
          EasyBtn(label: tr(AppL10n.advanceAdd), onPressed: () {}),
          EasyBtn(label: tr(AppL10n.advanceReplace), onPressed: () {}),
          Spacer(),
          PresetBtn(),
        ],
      ),
    );
  }
}
