import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/core/file.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class FilterFileBtn extends ConsumerWidget {
  const FilterFileBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String removeUnselectedLabel = S.of(context).removeUnselected;
    final String removeSelectedLabel = S.of(context).removeSelected;
    final String allExtLabel = S.of(context).allExtension;

    void removeUnchecked() {
      ref.read(fileListProvider.notifier).removeUncheck();
      Navigator.of(context).pop();
    }

    void removeChecked() {
      ref.read(fileListProvider.notifier).removeCheck();
      Navigator.of(context).pop();
    }

    DropdownMenuItem easyDropdownItem(
        String label, Color color, GestureTapCallback onTap) {
      return DropdownMenuItem(
        value: 0,
        child: InkWell(
          onTap: onTap,
          hoverColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            // color: Colors.green,
            padding: const EdgeInsets.only(left: AppNum.fileCardP),
            child: Text(label, style: TextStyle(color: color)),
          ),
        ),
      );
    }

    List<DropdownMenuItem> items = ref.watch(classifyListProvider).map(
      (e) {
        return DropdownMenuItem(
          value: e,
          child: StatefulBuilder(
            builder: (context, setState) {
              void toggleCheck(v) {
                final provider = ref.read(fileListProvider.notifier);
                provider.checkClassify(e, !isCheck(ref, e));
                updateName(ref);
                updateExtension(ref);
                setState(() {});
              }

              return GestureDetector(
                onTap: () => toggleCheck(false),
                child: Container(
                  color: Colors.transparent,
                  child: EasyCheckbox(
                    e.value,
                    checked: isCheck(ref, e),
                    onChanged: toggleCheck,
                  ),
                ),
              );
            },
          ),
        );
      },
    ).toList();

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonStyleData: const ButtonStyleData(
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
        ),
        customButton: const Icon(
          Icons.filter_alt_rounded,
          size: AppNum.defaultIconS,
          color: AppColors.icon,
        ),
        items: [
          easyDropdownItem(removeUnselectedLabel, Colors.red, removeUnchecked),
          easyDropdownItem(removeSelectedLabel, Colors.red, removeChecked),
          ...items,
          if (items.isNotEmpty) ...[
            easyDropdownItem(
              allExtLabel,
              Theme.of(context).primaryColor,
              () => showAllType(context, true),
            ),
            easyDropdownItem(
              S.of(context).selectReserve,
              Theme.of(context).primaryColor,
              () {
                ref.read(fileListProvider.notifier).checkReverse();
                updateName(ref);
                updateExtension(ref);
              },
            ),
          ]
        ],
        onChanged: (v) {},
        dropdownStyleData: DropdownStyleData(
          width: AppNum.dropdownMenuW,
          padding: const EdgeInsets.symmetric(vertical: AppNum.dropdownMenuP),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          offset: const Offset(-48, 0),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: AppNum.dropdownMenuItemH,
          padding: EdgeInsets.symmetric(horizontal: AppNum.fileCardP),
        ),
      ),
    );
  }
}
