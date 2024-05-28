import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/normal_tile.dart';

class ImageViewTitleBar extends ConsumerWidget {
  const ImageViewTitleBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int total = ref.watch(fileListProvider).length;
    final String title = S.of(context).fileCount(total);

    return Row(
      children: [
        NormalTile(label: title, padding: EdgeInsets.zero),
        const Spacer(),
        ClickIcon(
          svg: ref.watch(fileSortTypeProvider).value,
          size: AppNum.fileCardH,
          iconSize: 22,
          color: AppColors.icon,
          onTap: () => toggleSortType(ref),
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
