import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/file.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/views/content_bar/rename/sort_btn.dart';
import 'package:once_power/widgets/content_bar/check_tile.dart';

class ViewModeTitleBar extends ConsumerWidget {
  const ViewModeTitleBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int total = ref.watch(fileListProvider).length;
    int selected = ref.watch(selectFileProvider);
    final String title = S.of(context).fileCount(selected, total);

    return Row(
      children: [
        CheckTile(
          check: ref.watch(selectAllProvider),
          label: title,
          fontSize: 14,
          onChanged: (v) => selectAll(ref),
        ),
        const Spacer(),
        const SizedBox(
          width: AppNum.extensionW,
          child: Center(child: SortBtn()),
        ),
        SizedBox(
          width: AppNum.deleteBtnS,
          child: Center(
            child: IconButton(
              onPressed: () => showAllType(context),
              color: AppColors.icon,
              icon: const Icon(Icons.filter_alt_rounded),
            ),
          ),
        ),
        SizedBox(
          width: AppNum.deleteBtnS,
          child: Center(
            child: IconButton(
              onPressed: () => deleteAll(ref),
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
