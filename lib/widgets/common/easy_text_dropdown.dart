import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class EasyTextDropdown<T> extends StatelessWidget {
  const EasyTextDropdown(
      {super.key, this.items, this.value, this.width, this.onChanged});

  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final double? width;
  final void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        items: items,
        value: value,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          height: 32,
          width: width ?? 96,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(borderRadius: borderRadius),
        ),
        dropdownStyleData: DropdownStyleData(
          width: width ?? 100,
          elevation: 2,
          offset: Offset(0, -4),
          padding: const EdgeInsets.symmetric(vertical: 0),
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
