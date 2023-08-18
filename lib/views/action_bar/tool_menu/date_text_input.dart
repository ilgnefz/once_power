import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/views/action_bar/tool_menu/date_selected.dart';
import 'package:once_power/widgets/action_bar/common_input_menu.dart';
import 'package:once_power/widgets/digit_input.dart';

class DateTextInput extends HookConsumerWidget {
  const DateTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String dateLabel = '日期';
    const String dateTip = '以日期命名';

    const int defaultDateLength = 8;
    const String dateLengthLabel = '位';
    final dateLengthController = useTextEditingController(
      text: '$defaultDateLength$dateLengthLabel',
    );
    dateLengthController.addListener(() {
      String num = dateLengthController.text.isEmpty
          ? defaultDateLength.toString()
          : dateLengthController.text.replaceAll(dateLengthLabel, '');
      ref.read(dateLengthProvider.notifier).update(int.parse(num));
    });

    return CommonInputMenu(
      label: dateLabel,
      slot: Row(
        children: [
          Expanded(
            child: DigitInput(
              controller: dateLengthController,
              value: defaultDateLength,
              label: dateLengthLabel,
            ),
          ),
          const SizedBox(width: 8),
          const DateSelected(),
        ],
      ),
      message: dateTip,
      icon: AppIcons.date,
      selected: ref.watch(dateRenameProvider),
      onTap: ref.read(dateRenameProvider.notifier).update,
    );
  }
}
