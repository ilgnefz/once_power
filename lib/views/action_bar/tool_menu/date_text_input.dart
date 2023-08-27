import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/rename.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/views/action_bar/tool_menu/date_selected.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';
import 'package:once_power/widgets/digit_input.dart';

class DateTextInput extends ConsumerWidget {
  const DateTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String dateLabel = '日期';
    const String dateTip = '以日期命名';

    const int defaultDateLength = 8;
    const String dateLengthLabel = '位';

    TextEditingController controller = ref.watch(dateLengthControllerProvider);

    return CommonInputMenu(
      label: dateLabel,
      slot: Row(
        children: [
          Expanded(
            child: DigitInput(
              controller: controller,
              value: defaultDateLength,
              label: dateLengthLabel,
              callback: () async {
                updateName(ref);
                int num = int.parse(controller.text.replaceAll('位', ''));
                await StorageUtil.setInt(AppKeys.dateLength, num);
              },
              onChanged: (v) async {
                updateName(ref);
                await StorageUtil.setInt(AppKeys.dateLength, int.parse(v));
              },
            ),
          ),
          const SizedBox(width: 8),
          const DateSelected(),
        ],
      ),
      message: dateTip,
      icon: AppIcons.date,
      selected: ref.watch(dateRenameProvider),
      onTap: () {
        ref.read(dateRenameProvider.notifier).update();
        ref.watch(modifyControllerProvider).clear();
        if (ref.watch(currentModeProvider) == FunctionMode.reserve) {
          ref.watch(matchControllerProvider).clear();
        }
        updateName(ref);
      },
    );
  }
}
