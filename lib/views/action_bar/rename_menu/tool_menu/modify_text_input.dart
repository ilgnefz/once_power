import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/custom_tooltip.dart';
import 'package:once_power/widgets/input/input.dart';

class ModifyTextInput extends ConsumerWidget {
  const ModifyTextInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String caseDesc = S.of(context).caseDesc;
    final String today = S.of(context).today;
    final String modifyTo = S.of(context).modifyTo;
    final String inputDisable = S.of(context).inputDisable;

    bool dateRename = ref.watch(dateRenameProvider);
    bool reverseMode = ref.watch(currentModeProvider) == FunctionMode.reserve;
    bool inputNotEmpty = ref.watch(matchClearProvider);
    bool reserveTypeEmpty = ref.watch(currentReserveTypeProvider).isNotEmpty;
    bool disable =
        dateRename || (reverseMode && (inputNotEmpty || reserveTypeEmpty));

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

    return CommonInputMenu(
      disable: disable,
      slot: BaseInput(
        controller: ref.watch(modifyControllerProvider),
        hintText: disable ? inputDisable : modifyTo,
        show: ref.watch(modifyClearProvider),
        onChanged: (v) => updateName(ref),
        action: CustomTooltip(
          message: today,
          textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666))
              .useSystemChineseFont(),
          child: ClickIcon(
            svg: AppIcons.date,
            color: AppColors.unselectIcon,
            onTap: todayDate,
          ),
        ),
      ),
      message: caseDesc,
      icon: AppIcons.cases,
      selected: ref.watch(matchCaseProvider),
      onTap: toggleCase,
    );
  }
}
