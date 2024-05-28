import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/views/content_bar/filter_file_button.dart';
import 'package:once_power/widgets/check_tile.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/normal_tile.dart';

class RenameTitleBar extends ConsumerWidget {
  const RenameTitleBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String originName = S.of(context).originalName;
    final String renameName = S.of(context).renamedName;

    int selected = ref.watch(selectFileProvider);
    int total = ref.watch(fileListProvider).length;

    return Row(
      children: [
        CheckTile(
          check: ref.watch(selectAllProvider),
          label: '$originName ($selected/$total)',
          onChanged: (v) => selectAll(ref),
          action: ClickIcon(
            svg: ref.watch(fileSortTypeProvider).value,
            size: AppNum.fileCardH,
            iconSize: 22,
            color: AppColors.icon,
            onTap: () => toggleSortType(ref),
          ),
        ),
        NormalTile(label: renameName),
        const SizedBox(
          width: AppNum.extensionW,
          child: Center(child: FilterFileButton()),
        ),
        SizedBox(
          width: AppNum.deleteW,
          child: Center(
            child: IconButton(
              onPressed: () => deleteAll(ref),
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
