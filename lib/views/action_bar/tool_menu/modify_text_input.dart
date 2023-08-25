import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/rename.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';

class ModifyTextInput extends ConsumerWidget {
  const ModifyTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String matchCaseTip = '区分大小写';
    const String modifyTextHint = '修改为';
    const String disableHint = '输入已禁用';

    bool dateRename = ref.watch(dateRenameProvider);
    bool reverseMode = ref.watch(currentModeProvider) == FunctionMode.reserve;

    return CommonInputMenu(
      disable: dateRename || reverseMode,
      controller: ref.watch(modifyControllerProvider),
      hintText: dateRename || reverseMode ? disableHint : modifyTextHint,
      show: ref.watch(modifyClearProvider),
      onChanged: (v) => updateName(ref),
      message: matchCaseTip,
      icon: AppIcons.cases,
      selected: ref.watch(matchCaseProvider),
      onTap: () {
        ref.read(matchCaseProvider.notifier).update();
        updateName(ref);
      },
    );
  }
}
