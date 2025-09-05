import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/debounce.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/widgets/action/action_item.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/base/easy_tooltip.dart';
import 'package:once_power/widgets/common/click_icon.dart';

final _enableModifyProvider = Provider<bool>((ref) {
  FunctionMode mode = ref.watch(currentModeProvider);
  if (mode.isReplace) {
    return !ref.watch(isDateRenameProvider);
  }
  if (mode.isReserve) {
    return ref.watch(selectedReserveTypeProvider).isEmpty &&
        !ref.watch(isDateRenameProvider) &&
        !ref.watch(matchClearProvider);
  }
  return true;
});

class ModifyGroup extends ConsumerWidget {
  const ModifyGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool enable = ref.watch(_enableModifyProvider);
    TextEditingController controller = ref.watch(modifyControllerProvider);

    void onKeyEvent(KeyEvent event, TextEditingController controller) {
      int? num = int.tryParse(controller.text);
      if (num != null && event is KeyUpEvent) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) num++;
        if (event.logicalKey == LogicalKeyboardKey.arrowDown) num--;
        ref.read(modifyControllerProvider.notifier).updateText('$num');
        controller.selection = TextSelection.collapsed(
          offset: controller.text.length,
        );
        Debounce.run(() => updateName(ref));
      }
    }

    void onPressed() {
      String today = formatDateTime(DateTime.now());
      ref
          .read(modifyControllerProvider.notifier)
          .updateText(today.substring(0, 8));
      updateName(ref);
    }

    return ActionItem(
      tip: tr(AppL10n.renameCase),
      icon: AppIcons.cases,
      checked: ref.watch(isCaseSensitiveProvider),
      onPressed: () {
        ref.read(isCaseSensitiveProvider.notifier).update();
        Debounce.run(() => updateName(ref));
      },
      child: BaseInput(
        hintText: enable ? tr(AppL10n.renameModify) : tr(AppL10n.renameDisable),
        controller: controller,
        show: ref.watch(modifyClearProvider),
        onChanged: (value) => Debounce.run(() => updateName(ref)),
        enable: enable,
        onClear: () {
          ref.read(modifyControllerProvider.notifier).clear();
          updateName(ref);
        },
        trailing: EasyTooltip(
          tip: tr(AppL10n.renameToday),
          child: ClickIcon(
            svg: AppIcons.date,
            onPressed: enable ? onPressed : null,
          ),
        ),
        onKeyEvent: (event) => onKeyEvent(event, controller),
      ),
    );
  }
}
