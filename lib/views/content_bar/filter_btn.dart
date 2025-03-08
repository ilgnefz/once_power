import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/cores/rename.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/file_enum.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/list.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/utils/verify.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';
import 'package:once_power/widgets/common/easy_icon_dropdown.dart';

import '../../cores/update_name.dart';

class FilterBtn extends ConsumerWidget {
  const FilterBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DropdownMenuItem easyDropdownItem(
        String label, Color color, void Function()? onTap,
        [bool isDialog = false]) {
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
                  child: Text(label, style: TextStyle(color: color)),
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
                  mainAxisSize: MainAxisSize.max,
                  checked: isCheck(ref, e),
                  label: e.label,
                  onChanged: (value) => toggleCheck(),
                ),
              ),
            );
          },
        ),
      );
    }).toList();

    return EasyIconDropdown(
      icon: Icons.filter_alt_rounded,
      items: [
        easyDropdownItem(
          S.of(context).removeUnselected,
          Colors.red,
          () => ref.read(fileListProvider.notifier).removeUncheck(),
        ),
        easyDropdownItem(
          S.of(context).removeSelected,
          Colors.red,
          () => ref.read(fileListProvider.notifier).removeCheck(),
        ),
        ...items,
        easyDropdownItem(
          S.of(context).allExtension,
          Theme.of(context).primaryColor,
          () async => await showAllType(context, false, true),
          true,
        ),
        easyDropdownItem(
          S.of(context).allFolder,
          Theme.of(context).primaryColor,
          () async => await showAllType(context, true, true),
          true,
        ),
        easyDropdownItem(
          S.of(context).selectReserve,
          Theme.of(context).primaryColor,
          () {
            if (ref.watch(fileListProvider).isEmpty) return;
            ref.read(fileListProvider.notifier).checkReverse();
            updateName(ref);
          },
        ),
      ],
      padding: 0,
      // offset: Offset(-36, -4),
      width: ref.watch(currentLanguageProvider).isEnglish()
          ? AppNum.dropdownMenuWE
          : AppNum.dropdownMenuWC,
    );
  }
}
