import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/input_field.dart';

class TargetInput extends ConsumerWidget {
  const TargetInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: .symmetric(horizontal: AppNum.padding),
      // child: FolderInput(
      //   cacheKey: AppKeys.targetFolder,
      //   controller: ref.watch(folderControllerProvider),
      //   onUpload: (value) =>
      //       ref.read(folderControllerProvider.notifier).update(value),
      // ),
      child: InputField(
        controller: ref.watch(folderControllerProvider),
        hintText: tr(AppL10n.organizeTarget),
        onClear: () => StorageUtil.remove(AppKeys.targetFolder),
        onChanged: (value) =>
            StorageUtil.setString(AppKeys.targetFolder, value),
        action: ClickIcon(
          icon: Icons.folder_open_rounded,
          onPressed: () async {
            final String? folder = await getDirectoryPath();
            if (folder == null || folder.isEmpty) return;
            ref.read(folderControllerProvider.notifier).update(folder);
            StorageUtil.setString(AppKeys.targetFolder, folder);
          },
        ),
      ),
    );
  }
}
