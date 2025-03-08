import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/colors.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/utils/verify.dart';
import 'package:once_power/widgets/action_bar/operate_item.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

import '../../../cores/update_name.dart';

class ModifyInput extends ConsumerWidget {
  const ModifyInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = ref.watch(modifyControllerProvider);

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

    return OperateItem(
      icon: AppIcons.cases,
      tip: S.of(context).caseDesc,
      selected: ref.watch(isCaseSensitiveProvider),
      onToggle: () {
        ref.read(isCaseSensitiveProvider.notifier).update();
        updateName(ref);
      },
      child: BaseInput(
        hintText: S.of(context).modifyTo,
        controller: controller,
        // padding: EdgeInsets.only(left: AppNum.inputP, right: AppNum.smallG),
        enable: isEnableModify(ref),
        showClear: ref.watch(modifyClearProvider),
        onClear: () {
          ref.read(modifyControllerProvider.notifier).clear();
          updateName(ref);
        },
        onKeyEvent: onKeyEvent,
        onChanged: (value) => updateName(ref),
        trailing: TooltipIcon(
          tip: S.of(context).today,
          svg: AppIcons.date,
          color: AppColors.unselectIcon,
          onTap: () {
            if (ref.watch(currentModeProvider).isReserve) {
              ref.read(matchControllerProvider.notifier).clear();
              ref.read(currentReserveTypeProvider.notifier).clear();
            }
            int dateLen = ref.watch(dateLengthValueProvider);
            String now = formatDateTime(DateTime.now());
            String date =
                now.substring(0, dateLen > now.length ? now.length : dateLen);
            ref.read(modifyControllerProvider.notifier).updateText(date);
            updateName(ref);
          },
        ),
      ),
    );
  }
}
