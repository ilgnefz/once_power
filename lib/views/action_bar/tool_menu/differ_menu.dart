import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';

import '../../../widgets/easy_chip.dart';

class DifferMenu extends HookConsumerWidget {
  const DifferMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(currentModeProvider);

    // 保留模式时也应该出现修改输入框
    if (mode == FunctionMode.reserve) {
      final currentReserveType = ref.watch(currentReserveTypeProvider);

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ReserveType.values
            .map(
              (e) => EasyChip(
                label: e.value,
                selected: currentReserveType.contains(e),
                // enable: false,
                onTap: () =>
                    ref.read(currentReserveTypeProvider.notifier).update(e),
              ),
            )
            .toList(),
      );
    }

    if (mode == FunctionMode.remove) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: RemoveType.values
            .map(
              (e) => EasyChip(
                label: e.value,
                selected: ref.watch(currentRemoveTypeProvider) == e,
                // enable: false,
                onTap: () =>
                    ref.read(currentRemoveTypeProvider.notifier).update(e),
              ),
            )
            .toList(),
      );
    }

    const String modifyTextHint = '修改为';
    const String matchCaseTip = '区分大小写';

    // 修改内容
    final modifyTextController = useTextEditingController();
    final modifyInputShow = useState(false);
    modifyTextController.addListener(() {
      modifyInputShow.value = modifyTextController.text.isNotEmpty;
      ref.read(modifyTextProvider.notifier).update(modifyTextController.text);
    });

    return CommonInputMenu(
      controller: modifyTextController,
      hintText: modifyTextHint,
      show: modifyInputShow.value,
      message: matchCaseTip,
      icon: AppIcons.cases,
      selected: ref.watch(matchCaseProvider),
      onTap: ref.read(matchCaseProvider.notifier).update,
    );
  }
}
