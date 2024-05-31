import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/input/input.dart';

import 'date_selected.dart';

class DateTextInput extends ConsumerWidget {
  const DateTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String dateLabel = S.of(context).date;
    final String dateTip = S.of(context).dateDesc;

    const int defaultDateLength = 8;
    final String dateLengthLabel = S.of(context).digits;

    TextEditingController controller = ref.watch(dateLengthControllerProvider);

    void getLengthNum() async {
      updateName(ref);
      int num = getNum(controller.text);
      await StorageUtil.setInt(AppKeys.dateLength, num);
    }

    void lengthNumInput(v) async {
      updateName(ref);
      await StorageUtil.setInt(AppKeys.dateLength, int.parse(v));
    }

    void toggleDateRename() async {
      ref.read(dateRenameProvider.notifier).update();
      bool isReserve = ref.watch(currentModeProvider) == FunctionMode.reserve;
      bool dateRename = ref.watch(dateRenameProvider);

      if (dateRename) {
        String modifyText = ref.watch(modifyControllerProvider).text;
        await StorageUtil.setString(AppKeys.modifyCache, modifyText);
        ref.read(modifyControllerProvider).clear();
        if (isReserve) {
          String matchText = ref.watch(matchControllerProvider).text;
          await StorageUtil.setString(AppKeys.matchCache, matchText);
          ref.read(matchControllerProvider).clear();
        }
      }

      if (!dateRename) {
        String modifyCache = StorageUtil.getString(AppKeys.modifyCache) ?? '';
        ref.read(modifyControllerProvider.notifier).updateText(modifyCache);
        if (isReserve) {
          String matchCache = StorageUtil.getString(AppKeys.matchCache) ?? '';
          ref.read(matchControllerProvider.notifier).updateText(matchCache);
        }
      }
      updateName(ref);
    }

    return CommonInputMenu(
      label: dateLabel,
      slot: Row(
        children: [
          Expanded(
            child: DigitInput(
              controller: controller,
              value: defaultDateLength,
              label: dateLengthLabel,
              callback: getLengthNum,
              onChanged: lengthNumInput,
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(child: DateSelected()),
        ],
      ),
      message: dateTip,
      icon: AppIcons.date,
      selected: ref.watch(dateRenameProvider),
      onTap: toggleDateRename,
    );
  }
}
