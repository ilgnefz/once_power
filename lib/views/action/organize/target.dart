import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/action/folder_input.dart';

final _enableProvider = Provider((ref) {
  return !ref.watch(useGroupOrganizeProvider) &&
      !ref.watch(useTypeOrganizeProvider) &&
      !ref.watch(useTopFolderProvider);
});

class TargetInput extends ConsumerWidget {
  const TargetInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
      child: FolderInput(
        cacheKey: AppKeys.targetFolder,
        cacheListKey: AppKeys.targetFolderList,
        enable: ref.watch(_enableProvider),
        controller: ref.read(folderControllerProvider),
        showClear: ref.watch(folderClearProvider),
        cache: ref.watch(isSaveConfigProvider),
      ),
    );
  }
}
