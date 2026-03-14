import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/upload.dart';
import 'package:once_power/widget/base/tooltip.dart';
import 'package:once_power/widget/common/button.dart';

class FilePickerGroup extends ConsumerWidget {
  const FilePickerGroup({super.key, required this.slot});

  final Widget slot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: Row(
        spacing: AppNum.spaceSmall,
        children: [
          EasyButton(
            label: tr(AppL10n.actionUploadFile),
            onPressed: () => uploadFile(ref),
          ),
          EasyButton(
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
