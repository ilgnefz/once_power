import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/base/easy_tooltip.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

class TimeClassifyCheckbox extends ConsumerWidget {
  const TimeClassifyCheckbox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyCheckbox(
      label: S.of(context).dateClassification,
      checked: ref.watch(useDateClassifyProvider),
      onChanged: (value) {
        ref.read(useDateClassifyProvider.notifier).toggle();
        ref.read(useRuleOrganizeProvider.notifier).update(false);
        ref.read(useTopParentsProvider.notifier).update(false);
      },
    );
  }
}
