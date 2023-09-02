import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/widgets/normal_tile.dart';

class ArrangeTitleBar extends ConsumerWidget {
  const ArrangeTitleBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String name = '名称';
    const String type = '扩展';
    const String folder = '文件夹';
    int total = ref.watch(fileListProvider).length;

    return Row(
      children: [
        NormalTile(label: '$name ($total)'),
        const SizedBox(width: AppNum.gapW + 24),
        const NormalTile(label: folder),
        const SizedBox(width: AppNum.deleteW, child: Center(child: Text(type))),
        SizedBox(
          width: AppNum.deleteW,
          child: Center(
            child: IconButton(
              onPressed: ref.read(fileListProvider.notifier).clear,
              color: AppColors.icon,
              icon: const Icon(Icons.delete_rounded),
            ),
          ),
        ),
      ],
    );
  }
}
