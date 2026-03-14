import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/widget/common/button.dart';

import 'preset/preset.dart';

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
          EasyButton(
            label: tr(AppL10n.advanceDelete),
            onPressed: () => deleteText(context),
          ),
          EasyButton(
            label: tr(AppL10n.advanceAdd),
            onPressed: () => addText(context),
          ),
          EasyButton(
            label: tr(AppL10n.advanceReplace),
            onPressed: () => replaceText(context),
          ),
          Spacer(),
          PresetButton(),
        ],
      ),
    );
  }
}
