import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/upload.dart';
import 'package:once_power/widgets/base/easy_btn.dart';

class ApplyGroup extends ConsumerWidget {
  const ApplyGroup({super.key, required this.slot});

  final Widget slot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: Row(
        spacing: AppNum.spaceSmall,
        children: [
          EasyBtn(
            label: tr(AppL10n.actionUploadFile),
            onPressed: () => uploadFile(ref),
          ),
          EasyBtn(
            label: tr(AppL10n.actionUploadFolder),
            onPressed: () => uploadFolder(ref),
          ),
          Spacer(),
          slot,
        ],
      ),
    );
  }
}
