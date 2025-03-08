import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/progress.dart';

class TaskInfo extends ConsumerWidget {
  const TaskInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String currentTask = S.of(context).currentTask;
    final String takeTime = S.of(context).takeTime;
    int count = ref.watch(countProvider);
    int total = ref.watch(totalProvider);
    String cost = ref.watch(costProvider).toStringAsFixed(2);

    return Text(
      '$currentTask: $count/$total $takeTime: ${cost}s',
      style: const TextStyle(fontSize: 13, color: Colors.grey)
          .useSystemChineseFont(),
    );
  }
}
