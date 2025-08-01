import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/action_bar/folder_input.dart';

class TargetFolderInput extends ConsumerWidget {
  const TargetFolderInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = ref.read(folderControllerProvider);
    return Padding(
      padding: EdgeInsets.only(left: AppNum.largeG, right: AppNum.mediumG),
      child: FolderInput(
        cacheKey: AppKeys.targetFolder,
        cacheListKey: AppKeys.targetFolderList,
        enable: !ref.watch(useRuleOrganizeProvider) &&
            !ref.watch(useTopParentsProvider) &&
            !ref.watch(useGroupOrganizeProvider),
        hintText: S.of(context).targetFolder,
        controller: controller,
        showClear: ref.watch(folderClearProvider),
        cache: ref.watch(isSaveConfigProvider),
      ),
    );
  }
}
