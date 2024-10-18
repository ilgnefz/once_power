import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/file.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/views/content_bar/rename/filter_file_btn.dart';
import 'package:once_power/widgets/content_bar/check_tile.dart';
import 'package:once_power/widgets/content_bar/normal_tile.dart';

class OrganizeTitleBar extends ConsumerWidget {
  const OrganizeTitleBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String name = S.of(context).fileName;
    final String folder = S.of(context).folder;
    int selected = ref.watch(selectFileProvider);
    int total = ref.watch(fileListProvider).length;

    return Row(
      children: [
        CheckTile(
          check: ref.watch(selectAllProvider),
          label: '$name ($selected/$total)',
          fontSize: 14,
          onChanged: (v) => selectAll(ref),
        ),
        // NormalTile(label: '$name ($total)'),
        // const SizedBox(width: AppNum.smallG + 24),
        NormalTile(label: folder),
        // SizedBox(width: AppNum.deleteBtnS, child: Center(child: Text(type))),
        const SizedBox(
          width: AppNum.extensionW,
          child: Center(child: FilterFileBtn()),
        ),
        SizedBox(
          width: AppNum.deleteBtnS,
          child: Center(
            child: IconButton(
              onPressed: ref.read(fileListProvider.notifier).clear,
              color: AppColors.icon,
              icon: const Icon(Icons.delete_rounded),
            ),
          ),
        ),
        const SizedBox(width: AppNum.defaultP),
      ],
    );
  }
}
