import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/rename.dart';
import 'package:once_power/views/content_bar/filter_file_button.dart';
import 'package:once_power/widgets/check_tile.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/normal_tile.dart';

class TopTitleBar extends ConsumerWidget {
  const TopTitleBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String originName = '原始名称';
    const String renameName = '重命名名称';

    void toggleSortType() {
      int index = SortType.values.indexOf(ref.read(fileSortTypeProvider));
      ++index;
      if (index > SortType.values.length - 1) index = 0;
      SortType type = SortType.values[index];
      ref.read(fileSortTypeProvider.notifier).update(type);
      updateName(ref);
      updateExtension(ref);
    }

    void deleteAll() {
      ref.read(fileListProvider.notifier).clear();
      ref.read(totalProvider.notifier).clear();
    }

    int selected = ref.watch(selectFileProvider);
    int total = ref.watch(fileListProvider).length;

    return SizedBox(
      height: AppNum.fileCardH,
      // width: double.infinity,
      child: Row(
        children: [
          CheckTile(
            check: ref.watch(selectAllProvider),
            label: '$originName ($selected/$total)',
            onChanged: (v) {
              ref.read(selectAllProvider.notifier).update();
              updateName(ref);
              updateExtension(ref);
            },
            action: ClickIcon(
              svg: ref.watch(fileSortTypeProvider).value,
              size: AppNum.fileCardH,
              iconSize: 22,
              color: AppColors.icon,
              onTap: toggleSortType,
            ),
          ),
          const NormalTile(label: renameName),
          const SizedBox(
            width: AppNum.extensionW,
            child: Center(child: FilterFileButton()),
          ),
          SizedBox(
            width: AppNum.deleteW,
            child: Center(
              child: IconButton(
                onPressed: deleteAll,
                color: AppColors.icon,
                icon: const Icon(Icons.delete_forever_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
