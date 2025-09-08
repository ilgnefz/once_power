import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/sort.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/base/easy_icon.dart';
import 'package:once_power/widgets/common/dropdown_icon.dart';

class SortBtn extends ConsumerWidget {
  const SortBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    return IconDropdown(
      svg: ref.watch(currentSortProvider).icon,
      isExpanded: true,
      offset: Offset(0, -4),
      width: AppNum.dropdownMenuC,
      items: SortType.values.map((e) {
        return DropdownMenuItem(
          value: e,
          onTap: () {
            ref.read(currentSortProvider.notifier).update(e);
            updateName(ref);
          },
          child: Row(
            spacing: 4,
            children: [
              EasyIcon(svg: e.icon, iconSize: 18, color: theme.iconTheme.color),
              Expanded(
                child: Text(
                  e.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
