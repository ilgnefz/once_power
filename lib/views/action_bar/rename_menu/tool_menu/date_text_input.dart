import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/input/input.dart';

import 'date_selected.dart';

class DateTextInput extends ConsumerWidget {
  const DateTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String dateLabel = '日期';
    const String dateTip = '以日期命名';

    const int defaultDateLength = 8;
    const String dateLengthLabel = '位';

    TextEditingController controller = ref.watch(dateLengthControllerProvider);

    void getLengthNum() async {
      updateName(ref);
      int num = int.parse(controller.text.replaceAll(dateLengthLabel, ''));
      await StorageUtil.setInt(AppKeys.dateLength, num);
    }

    void lengthNumInput(v) async {
      updateName(ref);
      await StorageUtil.setInt(AppKeys.dateLength, int.parse(v));
    }

    void toggleDateRename() {
      ref.read(dateRenameProvider.notifier).update();
      ref.watch(modifyControllerProvider).clear();
      if (ref.watch(currentModeProvider) == FunctionMode.reserve) {
        ref.watch(matchControllerProvider).clear();
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
          const DateSelected(),
        ],
      ),
      message: dateTip,
      icon: AppIcons.date,
      selected: ref.watch(dateRenameProvider),
      onTap: toggleDateRename,
    );
  }
}
