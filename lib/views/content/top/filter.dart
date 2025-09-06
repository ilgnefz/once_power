import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/utils/verify.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';
import 'package:once_power/widgets/common/dropdown_icon.dart';

class FilterBtn extends ConsumerWidget {
  const FilterBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isEn = isEnglish(context);

    DropdownMenuItem easyDropdownItem(
      String label,
      Color color,
      void Function()? onTap, [
      bool isDialog = false,
    ]) {
      return DropdownMenuItem(
        value: 0,
        onTap: isDialog ? null : onTap,
        child: GestureDetector(
          onTap: isDialog ? onTap : null,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: color,
                      overflow: TextOverflow.ellipsis,
                      fontSize: isEn ? 13 : 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    List<DropdownMenuItem> items = ref.watch(classifyListProvider).map((e) {
      return DropdownMenuItem(
        value: e,
        child: StatefulBuilder(
          builder: (context, setState) {
            void toggleCheck() {
              final provider = ref.read(fileListProvider.notifier);
              provider.checkClassify(e, !isCheck(ref, e));
              updateName(ref);
              setState(() {});
            }

            return GestureDetector(
              onTap: toggleCheck,
              child: Container(
                padding: EdgeInsets.only(left: 4),
                color: Colors.transparent,
                child: EasyCheckbox(
                  // mainAxisSize: MainAxisSize.max,
                  checked: isCheck(ref, e),
                  label: e.label,
                  onChanged: (v) => toggleCheck(),
                ),
              ),
            );
          },
        ),
      );
    }).toList();

    return IconDropdown(
      icon: Icons.filter_alt_rounded,
      isExpanded: true,
      items: [
        easyDropdownItem(
          tr(AppL10n.contentFilterUnselected),
          Colors.red,
          () => ref.read(fileListProvider.notifier).removeUncheck(),
        ),
        easyDropdownItem(
          tr(AppL10n.contentFilterSelected),
          Colors.red,
          () => ref.read(fileListProvider.notifier).removeCheck(),
        ),
        ...items,
        easyDropdownItem(
          tr(AppL10n.contentFilterExtension),
          Theme.of(context).primaryColor,
          () async => await showAllTypeDetail(context, false, true),
          true,
        ),
        easyDropdownItem(
          tr(AppL10n.contentFilterFolder),
          Theme.of(context).primaryColor,
          () async => await showAllTypeDetail(context, true, true),
          true,
        ),
        easyDropdownItem(
          tr(AppL10n.contentFilterReserve),
          Theme.of(context).primaryColor,
          () {
            if (ref.watch(fileListProvider).isEmpty) return;
            ref.read(fileListProvider.notifier).checkReverse();
            updateName(ref);
          },
        ),
      ],
      padding: 0,
      offset: Offset(isEn ? -72 : -36, -4),
      width: isEn ? AppNum.dropdownMenuE : AppNum.dropdownMenuC,
    );
  }
}
