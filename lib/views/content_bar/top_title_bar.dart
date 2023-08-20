import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/get_file.dart';
import 'package:once_power/provider/select.dart';
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
      ref.read(fileSortTypeProvider.notifier).update(SortType.values[index]);
    }

    return SizedBox(
      height: AppNum.fileCardH,
      // width: double.infinity,
      child: Row(
        children: [
          CheckTile(
            originName,
            action: ClickIcon(
              svg: ref.watch(fileSortTypeProvider).value,
              size: AppNum.fileCardH,
              iconSize: 22,
              color: AppColors.icon,
              onTap: toggleSortType,
            ),
          ),
          const NormalTile(renameName),
          SizedBox(
            width: 64,
            child: Center(
              child: IconButton(
                onPressed: () {},
                color: AppColors.icon,
                icon: const Icon(Icons.filter_alt_rounded),
              ),
            ),
          ),
          SizedBox(
            width: 48,
            child: Center(
              child: IconButton(
                onPressed: ref.read(fileListProvider.notifier).clear,
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
