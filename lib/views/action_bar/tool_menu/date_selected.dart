import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/rename.dart';

final List<String> dateTypeList = [
  DateType.createDate.value,
  DateType.modifyDate.value,
  DateType.exifDate.value,
  DateType.earliestDate.value,
  DateType.latestDate.value
];

class DateSelected extends ConsumerWidget {
  const DateSelected({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        items: dateTypeList
            .map((String item) =>
                DropdownMenuItem<String>(value: item, child: Text(item)))
            .toList(),
        value: ref.watch(currentDateTypeProvider).value,
        onChanged: (value) {
          DateType type = DateType.values.firstWhere((e) => e.value == value);
          ref.read(currentDateTypeProvider.notifier).update(type);
          updateName(ref);
        },
        buttonStyleData: ButtonStyleData(
          height: 32,
          width: 96,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        ),
        dropdownStyleData: DropdownStyleData(
          width: 96,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(2),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
    );
  }
}