import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/sort.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/util/debounce.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/icon_dropdown.dart';

class SortButton extends ConsumerWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSort = ref.watch(currentSortProvider);
    return IconDropdown<SortType>(
      svg: currentSort.icon,
      items: SortType.values
          .map(
            (e) => DropdownItem<SortType>(
              value: e,
              key: ValueKey(e),
              height: AppNum.widgetHeight,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  height: AppNum.widgetHeight,
                  padding: EdgeInsets.symmetric(horizontal: AppNum.spaceMedium),
                  child: Row(
                    spacing: AppNum.spaceSmall,
                    children: [
                      BaseIcon(svg: e.icon, size: 17),
                      BaseText(e.label),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
      value: currentSort,
      width: 100,
      onChanged: (value) {
        ref.read(currentSortProvider.notifier).update(value);
        Debounce.run(() => updateName(ref));
      },
    );
  }
}
