import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/core/update.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/util/debounce.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/text_input.dart';

class ModifyInput extends ConsumerWidget {
  const ModifyInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      icon: AppIcons.cases,
      tip: tr(AppL10n.renameCase),
      checked: ref.watch(isCaseSensitiveProvider),
      onPressed: () {
        ref.read(isCaseSensitiveProvider.notifier).update();
        Debounce.run(() => normalUpdateName(ref));
      },
      child: TextInput(
        controller: ref.watch(modifyControllerProvider),
        hintText: tr(AppL10n.renameModify),
        action: ClickIcon(
          tip: tr(AppL10n.renameToday),
          onPressed: () {
            String today = formatDateTime(DateTime.now());
            today = today.substring(0, 8);
            ref.read(modifyControllerProvider.notifier).update(today);
            // TODO: 这里修改了 Controller 的值，或许并不需要这个方法
            // Debounce.run(() => updateName(ref));
          },
          svg: AppIcons.date,
        ),
      ),
    );
  }
}
