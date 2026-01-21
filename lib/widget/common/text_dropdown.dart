import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';

class TextDropdown<T> extends StatelessWidget {
  const TextDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final List<DropdownItem<T>> items;
  final T value;
  final void Function(T) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        items: items,
        valueListenable: ValueNotifier<T>(value),
        onChanged: (value) => onChanged(value as T),
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.symmetric(horizontal: AppNum.spaceMedium),
          height: AppNum.widgetHeight,
          width: 92,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(AppNum.radius),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          padding: EdgeInsets.zero,
          elevation: 2,
          // maxHeight: maxHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppNum.radius),
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all(2),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: AppNum.spaceMedium),
        ),
      ),
    );
  }
}
