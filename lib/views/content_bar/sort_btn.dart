import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/colors.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/sort_enum.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/widgets/base/svg_icon.dart';
import 'package:once_power/widgets/common/easy_icon_dropdown.dart';

class SortBtn extends ConsumerWidget {
  const SortBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                color: AppColors.icon,
              ),
              Text(e.label),
            ],
          ),
        );
      },
    ).toList();

    return EasyIconDropdown(
      svg: ref.watch(fileSortTypeProvider).icon,
      items: items,
      width: ref.watch(currentLanguageProvider).isEnglish()
          ? AppNum.dropdownMenuWE
          : AppNum.dropdownMenuWC,
    );
  }
}
