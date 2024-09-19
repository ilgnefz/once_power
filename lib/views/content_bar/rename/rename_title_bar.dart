import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:once_power/widgets/content_bar/check_tile.dart';
import 'package:once_power/widgets/content_bar/normal_tile.dart';

import 'filter_file_btn.dart';

class RenameTitleBar extends ConsumerWidget {
  const RenameTitleBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String originName = S.of(context).originalName;
    final String renameName = S.of(context).renameName;

    int selected = ref.watch(selectFileProvider);
    int total = ref.watch(fileListProvider).length;

    return Row(
      children: [
        CheckTile(
          check: ref.watch(selectAllProvider),
          label: '$originName ($selected/$total)',
          fontSize: 14,
          onChanged: (v) => selectAll(ref),
          action: ClickIcon(
            svg: ref.watch(fileSortTypeProvider).value,
            size: AppNum.fileCardH,
            iconSize: AppNum.defaultIconS - 2,
            color: AppColors.icon,
            onTap: () => toggleSortType(ref),
          ),
        ),
        NormalTile(label: renameName),
        const SizedBox(
          width: AppNum.extensionW,
          child: Center(child: FilterFileBtn()),
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
