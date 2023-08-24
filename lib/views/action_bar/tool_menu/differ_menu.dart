import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/rename.dart';
import 'package:once_power/widgets/action_bar/box_card.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';

import '../../../widgets/easy_chip.dart';

class DifferMenu extends ConsumerWidget {
  const DifferMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(currentModeProvider);
    const String matchCaseTip = '区分大小写';

    // 保留模式时也应该出现修改输入框
    if (mode == FunctionMode.reserve) {
      final currentReserveType = ref.watch(currentReserveTypeProvider);

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...ReserveType.values.map(
            (e) {
              return EasyChip(
                label: e.value,
                selected: currentReserveType.contains(e),
                enable: !ref.watch(matchClearProvider),
                onTap: () {
                  ref.read(currentReserveTypeProvider.notifier).update(e);
                  ref.watch(matchControllerProvider).clear();
                  updateName(ref);
                },
              );
            },
          ).toList(),
          BoxCard(
            AppIcons.cases,
            message: matchCaseTip,
            selected: ref.watch(matchCaseProvider),
            onTap: () {
              ref.read(matchCaseProvider.notifier).update();
              updateName(ref);
            },
          ),
        ],
      );
    }

    if (mode == FunctionMode.remove) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...RemoveType.values.map(
            (e) {
              return EasyChip(
                label: e.value,
                selected: ref.watch(currentRemoveTypeProvider) == e,
                // enable: false,
                onTap: () {
                  ref.read(currentRemoveTypeProvider.notifier).update(e);
                  updateName(ref);
                },
              );
            },
          ).toList(),
          BoxCard(
            AppIcons.cases,
            message: matchCaseTip,
            selected: ref.watch(matchCaseProvider),
            onTap: () {
              ref.read(matchCaseProvider.notifier).update();
              updateName(ref);
            },
          ),
        ],
      );
    }

    const String modifyTextHint = '修改为';

    const String disableHint = '输入已禁用';

    bool dateRename = ref.watch(dateRenameProvider);

    return CommonInputMenu(
      disable: dateRename,
      controller: ref.watch(modifyControllerProvider),
      hintText: dateRename ? disableHint : modifyTextHint,
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
