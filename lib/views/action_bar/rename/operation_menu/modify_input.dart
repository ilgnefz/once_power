import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/action_bar/action_input.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:once_power/widgets/common/custom_tooltip.dart';

class ModifyInput extends ConsumerWidget {
  const ModifyInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String caseDesc = S.of(context).caseDesc;
    final String today = S.of(context).today;
    final String modifyTo = S.of(context).modifyTo;
    final String inputDisable = S.of(context).inputDisable;

    bool dateRename = ref.watch(dateRenameProvider);
    bool reverseMode = ref.watch(currentModeProvider) == FunctionMode.reserve;
    bool inputNotEmpty = ref.watch(matchClearProvider);
    bool inputLength = ref.watch(inputLengthProvider);
    bool reserveTypeEmpty = ref.watch(currentReserveTypeProvider).isNotEmpty;
    bool disable = dateRename ||
        (reverseMode && (inputNotEmpty || reserveTypeEmpty || inputLength));
    final controller = ref.watch(modifyControllerProvider);

    void toggleCase() {
      ref.read(matchCaseProvider.notifier).update();
      updateName(ref);
    }

    void todayDate() {
      if (reverseMode) ref.watch(matchControllerProvider).clear();
      String dateDigitText = ref.watch(dateLengthControllerProvider).text;
      int dateDigit = getNum(dateDigitText);
      String date = formatDateTime(DateTime.now());
      ref.read(modifyControllerProvider.notifier).updateText(
          date.substring(0, dateDigit > date.length ? date.length : dateDigit));
      updateName(ref);
    }

    void onKeyEvent(event) {
      int? num = int.tryParse(controller.text);
      if (num != null && event is KeyUpEvent) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          ref
              .read(modifyControllerProvider.notifier)
              .updateText((num += 1).toString());
          updateName(ref);
        }
        if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          ref
              .read(modifyControllerProvider.notifier)
              .updateText((num -= 1).toString());
          updateName(ref);
        }
      }
    }

    return ActionInput(
      disable: disable,
      onKeyEvent: onKeyEvent,
      controller: controller,
      hintText: disable ? inputDisable : modifyTo,
      show: ref.watch(modifyClearProvider),
      onChanged: (v) => updateName(ref),
      action: EasyTooltip(
        message: today,
        textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666))
            .useSystemChineseFont(),
        child: ClickIcon(
          svg: AppIcons.date,
          color: AppColors.unselectIcon,
          onTap: todayDate,
        ),
      ),
      message: caseDesc,
      icon: AppIcons.cases,
      selected: ref.watch(matchCaseProvider),
      onTap: toggleCase,
    );
  }
}
