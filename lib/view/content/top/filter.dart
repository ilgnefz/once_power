import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/dialog.dart';
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
    required void Function() onPressed,
    Color? color,
    bool closeOnTap = true,
  }) {
    return DropdownItem(
      key: UniqueKey(),
      height: AppNum.widgetHeight,
      onTap: onPressed,
      closeOnTap: closeOnTap,
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

  void checkedPressed(WidgetRef ref, FileType e) {
    final provider = ref.read(fileListProvider.notifier);
    provider.checkClassify(e, !isCheckedClassify(ref, e));
    updateName(ref);
  }

  List<DropdownItem<dynamic>> buildCheckboxItems(WidgetRef ref) {
    return ref.read(fileTypeListProvider).map((e) {
      return DropdownItem(
        key: UniqueKey(),
        height: AppNum.widgetHeight,
        onTap: () => checkedPressed(ref, e.type),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: SizedBox(
            height: AppNum.widgetHeight,
            width: double.infinity,
            child: StatefulBuilder(
              builder: (context, setState) => EasyCheckbox(
                checked: isCheckedClassify(ref, e.type),
                label: '${e.type.label} (${e.count})',
                onChanged: (_) => setState(() => checkedPressed(ref, e.type)),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color color = Theme.of(context).primaryColor;
    return IconDropdown(
      icon: Icons.filter_alt_rounded,
      items: [
        buildTextItem(
          tr(AppL10n.contentFilterUnselected),
          color: Colors.red,
          onPressed: ref.read(fileListProvider.notifier).removeUncheck,
        ),
        buildTextItem(
          tr(AppL10n.contentFilterSelected),
          color: Colors.red,
          onPressed: ref.read(fileListProvider.notifier).removeCheck,
        ),
        ...buildCheckboxItems(ref),
        buildTextItem(
          tr(AppL10n.contentFilterExtension),
          color: color,
          closeOnTap: false,
          onPressed: () async => await showAllTypeDetail(context, false, true),
        ),
        buildTextItem(
          tr(AppL10n.contentFilterFolder),
          color: color,
          closeOnTap: false,
          onPressed: () async => await showAllTypeDetail(context, true, true),
        ),
        buildTextItem(
          tr(AppL10n.contentFilterReserve),
          color: color,
          onPressed: () {
            if (ref.watch(fileListProvider).isEmpty) return;
            ref.read(fileListProvider.notifier).checkReverse();
            updateName(ref);
          },
        ),
        buildTextItem(
          tr(AppL10n.contentFilterRule),
          color: color,
          closeOnTap: false,
          onPressed: () async => await showRuleDetail(context),
        ),
      ],
      value: null,
      padding: EdgeInsets.zero,
      onChanged: (value) {},
    );
  }
}
