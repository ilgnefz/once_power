import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:once_power/widgets/common/svg_icon.dart';

class SortBtn extends ConsumerWidget {
  const SortBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LanguageType type = ref.watch(currentLanguageProvider);
    bool isEnglish = type == LanguageType.english;

    void toggleSort(SortType type) {
      ref.read(fileSortTypeProvider.notifier).update(type);
      Navigator.pop(context);
    }

    List<DropdownMenuItem> items = SortType.values.map(
      (e) {
        return DropdownMenuItem(
          value: e,
          child: InkWell(
            onTap: () => toggleSort(e),
            hoverColor: Colors.transparent,
            child: Row(
              children: [
                ClickIcon(
                  svg: e.value,
                  size: AppNum.fileCardH,
                  iconSize: AppNum.defaultIconS,
                  color: AppColors.icon,
                ),
                Text(e.label),
              ],
            ),
          ),
        );
      },
    ).toList();

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonStyleData: const ButtonStyleData(
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
        ),
        customButton: SvgIcon(
          ref.watch(fileSortTypeProvider).value,
          size: AppNum.defaultIconS,
          color: AppColors.icon,
        ),
        items: items,
        onChanged: (v) {},
        dropdownStyleData: DropdownStyleData(
          width: AppNum.dropdownMenuW + (isEnglish ? 32 : -20),
          padding: const EdgeInsets.symmetric(vertical: AppNum.dropdownMenuP),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          offset: const Offset(-16, -4),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: AppNum.dropdownMenuItemH,
          padding: EdgeInsets.symmetric(horizontal: AppNum.fileCardP),
        ),
      ),
    );
  }
}
