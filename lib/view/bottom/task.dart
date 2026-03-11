import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/bottom_text.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/provider/progress.dart';

final Provider<String> taskProvider = Provider((Ref ref) {
  final String currentTask = tr(AppL10n.bottomTask);
  final String takeTime = tr(AppL10n.bottomTime);
  int count = ref.watch(countProvider);
  int total = ref.watch(totalProvider);
  String time = ref.watch(costProvider).toStringAsFixed(2);
  return '$currentTask: $count/$total  $takeTime: ${time}s';
});

class TaskMessage extends ConsumerWidget {
  const TaskMessage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      ref.watch(taskProvider),
      style: Theme.of(context).extension<BottomTextTheme>()?.textStyle,
    );
  }
}
