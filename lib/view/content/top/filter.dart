import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/util/verify.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/checkbox.dart';
import 'package:once_power/widget/common/icon_dropdown.dart';

class FilterButton extends ConsumerWidget {
  const FilterButton({super.key});

  DropdownItem<dynamic> buildTextItem(
    String title, {
    required VoidCallback onTap,
    Color? color,
  }) {
    return DropdownItem(
      key: UniqueKey(),
      height: AppNum.widgetHeight,
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: AppNum.widgetHeight,
          padding: EdgeInsets.symmetric(horizontal: AppNum.spaceMedium),
          alignment: Alignment.centerLeft,
          child: BaseText(title, color: color),
        ),
      ),
    );
  }

  void checkedPressed(WidgetRef ref, FileClassify e) {
    final provider = ref.read(fileListProvider.notifier);
    provider.checkClassify(e, !isCheckedClassify(ref, e));
    updateName(ref);
  }

  List<DropdownItem<dynamic>> buildCheckboxItems(WidgetRef ref) {
    return ref.watch(classifyListProvider).map((e) {
      return DropdownItem(
        key: UniqueKey(),
        height: AppNum.widgetHeight,
        onTap: () => checkedPressed(ref, e),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: SizedBox(
            height: AppNum.widgetHeight,
            width: double.infinity,
            child: StatefulBuilder(
              builder: (context, setState) => EasyCheckbox(
                checked: isCheckedClassify(ref, e),
                label: e.label,
                onChanged: (_) => setState(() => checkedPressed(ref, e)),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconDropdown(
      icon: Icons.filter_alt_rounded,
      items: [
        buildTextItem(
          tr(AppL10n.contentFilterUnselected),
          color: Colors.red,
          onTap: ref.read(fileListProvider.notifier).removeUncheck,
        ),
        buildTextItem(
          tr(AppL10n.contentFilterSelected),
          color: Colors.red,
          onTap: ref.read(fileListProvider.notifier).removeCheck,
        ),
        ...buildCheckboxItems(ref),
      ],
      value: null,
      padding: EdgeInsets.zero,
      onChanged: (value) {},
    );
  }
}
