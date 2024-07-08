import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/input/input.dart';

class TargetFolderInput extends ConsumerWidget {
  const TargetFolderInput({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String targetFolder = S.of(context).targetFolder;
    TextEditingController controller = ref.watch(targetControllerProvider);

    void onChanged(String folder) async {
      controller.text = folder;
      if (ref.watch(saveConfigProvider)) {
        StorageUtil.setString(AppKeys.targetFolder, folder);
      }
    }

    return BaseInput(
      hintText: targetFolder,
      // readOnly: true,
      controller: controller,
      onChanged: onChanged,
      show: ref.watch(targetClearProvider),
    );
  }
}
