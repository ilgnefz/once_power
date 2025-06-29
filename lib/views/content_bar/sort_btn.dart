import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/sort_enum.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/base/svg_icon.dart';
import 'package:once_power/widgets/common/easy_icon_dropdown.dart';

class SortBtn extends ConsumerWidget {
  const SortBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isEnglish = ref.watch(currentLanguageProvider).isEnglish();
    bool isOrganize = ref.watch(currentModeProvider).isOrganize;
    bool isViewMode = ref.watch(isViewModeProvider);
    double offsetX = isEnglish && !isOrganize && isViewMode ? -48 : -8;
    final theme = Theme.of(context);

    List<DropdownMenuItem> items = SortType.values.map(
      (e) {
        return DropdownMenuItem(
          value: e,
          onTap: () {
            ref.read(fileSortTypeProvider.notifier).update(e);
            updateName(ref);
          },
          child: Row(
            spacing: AppNum.smallG,
            children: [
              SvgIcon(
                e.icon,
                size: AppNum.dropdownIconS,
                color: theme.iconTheme.color,
              ),
              Expanded(
                child: Text(
                  e.label,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: ref.watch(currentLanguageProvider).isEnglish()
                        ? 13
                        : 14,
                    color: theme.textTheme.labelMedium?.color,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).toList();

    return EasyIconDropdown(
      svg: ref.watch(fileSortTypeProvider).icon,
      isExpanded: true,
      items: items,
      offset: Offset(offsetX, -4),
      width: isEnglish ? 158 : AppNum.dropdownMenuWC,
    );
  }
}
