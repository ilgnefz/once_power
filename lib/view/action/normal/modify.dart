import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide TextInput;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/core/update/normal.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/util/debounce.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/input_field.dart';

final Provider<bool> _enableProvider = Provider<bool>((Ref ref) {
  FunctionMode mode = ref.watch(currentModeProvider);
  bool matchIsEmpty = ref.watch(matchIsEmptyProvider);
  bool isDateRename = ref.watch(isDateRenameProvider);
  switch (mode) {
    case FunctionMode.replace:
      return !isDateRename;
    case FunctionMode.reserve:
      return ref.watch(selectedReserveTypeProvider).isEmpty &&
          matchIsEmpty &&
          !isDateRename;
    default:
      return true;
  }
});

class ModifyInput extends ConsumerWidget {
  const ModifyInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool enable = ref.watch(_enableProvider);
    TextEditingController controller = ref.watch(modifyControllerProvider);

    void updateInput(String text, int num) {
      // 保留前导零格式
      String newText;
      if (text.startsWith('0') && text.length > 1) {
        // 计算前导零的数量
        int leadingZeros = 0;
        while (leadingZeros < text.length && text[leadingZeros] == '0') {
          leadingZeros++;
        }
        // 格式化新数字，确保长度与原始输入相同
        String numStr = num.toString();
        if (numStr.length < text.length) {
          newText = '0' * (text.length - numStr.length) + numStr;
        } else {
          newText = numStr;
        }
      } else {
        newText = '$num';
      }
      ref.read(modifyControllerProvider.notifier).update(newText);
      Debounce.run(() => normalUpdateName(ref));
    }

    return ActionItem(
      icon: AppIcons.cases,
      tip: tr(AppL10n.renameCase),
      checked: ref.watch(isCaseSensitiveProvider),
      onPressed: () {
        ref.read(isCaseSensitiveProvider.notifier).update();
        Debounce.run(() => normalUpdateName(ref));
      },
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (KeyEvent event) {
          String text = controller.text;
          int? num = int.tryParse(text);
          if (num != null && event is KeyUpEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
              num++;
              updateInput(text, num);
            } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
              if (num > 0) num--;
              updateInput(text, num);
            }
          }
        },
        child: InputField(
          controller: controller,
          hintText: tr(AppL10n.renameModify),
          enabled: enable,
          onChanged: (_) => Debounce.run(() => normalUpdateName(ref)),
          action: ClickIcon(
            tip: tr(AppL10n.renameToday),
            onPressed: enable
                ? () {
                    String today = formatDateTime(DateTime.now());
                    today = today.substring(0, 8);
                    ref.read(modifyControllerProvider.notifier).update(today);
                    Debounce.run(() => normalUpdateName(ref));
                  }
                : null,
            svg: AppIcons.date,
          ),
        ),
      ),
    );
  }
}
