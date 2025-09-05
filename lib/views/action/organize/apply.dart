import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/widgets/base/easy_elevated_btn.dart';

class ApplyOrganize extends StatelessWidget {
  const ApplyOrganize({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyElevatedBtn(label: tr(AppL10n.organizeApply), onPressed: () {});
  }
}
