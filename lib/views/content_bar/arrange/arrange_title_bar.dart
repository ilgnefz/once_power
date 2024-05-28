import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/widgets/normal_tile.dart';

class ArrangeTitleBar extends ConsumerWidget {
  const ArrangeTitleBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String name = S.of(context).fileName;
    final String type = S.of(context).extension;
    final String folder = S.of(context).folder;
    int total = ref.watch(fileListProvider).length;

    return Row(
      children: [
        NormalTile(label: '$name ($total)'),
        const SizedBox(width: AppNum.gapW + 24),
        NormalTile(label: folder),
        SizedBox(width: AppNum.deleteW, child: Center(child: Text(type))),
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
        const SizedBox(width: AppNum.contentRP),
      ],
    );
  }
}
