import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/core/rename.dart';

final List<DateType> dateTypeList = [
  DateType.createdDate,
  DateType.modifiedDate,
  DateType.exifDate,
  DateType.earliestDate,
  DateType.latestDate,
  DateType.today,
  DateType.yesterday
];

final BorderRadius borderRadius = BorderRadius.circular(8);

class DateSelected extends ConsumerWidget {
  const DateSelected({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<DateType>(
        isExpanded: true,
        items: dateTypeList
            .map(
              (DateType item) => DropdownMenuItem<DateType>(
                value: item,
                child: Text(item.value),
              ),
            )
            .toList(),
        value: ref.watch(currentDateTypeProvider),
        onChanged: (v) {
          DateType type = DateType.values.firstWhere((e) => e == v);
          ref.read(currentDateTypeProvider.notifier).update(type);
          updateName(ref);
        },
        buttonStyleData: ButtonStyleData(
          height: 32,
          width: 96,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(borderRadius: borderRadius),
        ),
        dropdownStyleData: DropdownStyleData(
          width: 104,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all(2),
            thumbVisibility: WidgetStateProperty.all(true),
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
