import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/action_bar/folder_input.dart';

class TargetFolderInput extends ConsumerStatefulWidget {
  const TargetFolderInput({super.key});

  @override
  ConsumerState<TargetFolderInput> createState() => _TargetFolderInputState();
}

class _TargetFolderInputState extends ConsumerState<TargetFolderInput>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = ref.read(folderControllerProvider);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FolderInput(
      cacheKey: AppKeys.targetFolder,
      cacheListKey: AppKeys.targetFolderList,
      enable: !ref.watch(useRuleOrganizeProvider) &&
          !ref.watch(useTopParentsProvider),
      hintText: S.of(context).targetFolder,
      controller: controller,
      showClear: ref.watch(folderClearProvider),
      cache: ref.watch(isSaveConfigProvider),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
