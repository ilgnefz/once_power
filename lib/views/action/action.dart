import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/views/action/action_tab.dart';
import 'package:once_power/views/action/csv/csv.dart';
import 'package:once_power/views/action/date/date.dart';

final Provider<Widget> actionBarContentProvider = Provider<Widget>((ref) {
  if (ref.watch(cSVDataProvider).isNotEmpty) return CSVView();
  if (ref.watch(isDateModifyProvider)) return DateView();
  return ActionTabBar();
});

class ActionView extends ConsumerWidget {
  const ActionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AbsorbPointer(
      absorbing: ref.watch(isApplyingProvider),
      child: SizedBox(
        width: AppNum.action,
        child: ref.watch(actionBarContentProvider),
      ),
    );
  }
}
