import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:once_power/config/theme/dropdown.dart';
import 'package:once_power/const/num.dart';

class TextDropdown<T> extends StatelessWidget {
  const TextDropdown({
    super.key,
    required this.items,
    required this.value,
    this.width = 92,
    this.maxHeight,
    this.color,
    required this.onChanged,
  });

  final List<DropdownItem<T>> items;
  final T value;
  final double width;
  final double? maxHeight;
  final Color? color;
  final void Function(T) onChanged;

  @override
  Widget build(BuildContext context) {
    DropdownTheme? theme = Theme.of(context).extension<DropdownTheme>();
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        items: items,
        valueListenable: ValueNotifier<T>(value),
        onChanged: (value) => onChanged(value as T),
        buttonStyleData: ButtonStyleData(
          padding: const .symmetric(horizontal: AppNum.spaceMedium),
          height: AppNum.widgetHeight,
          width: width,
          decoration: BoxDecoration(
            color: color ?? theme?.menuBackgroundColor,
            borderRadius: .circular(AppNum.radius),
          ),
          overlayColor: .resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return Colors.transparent;
            }
            return null;
          }),
        ),
        dropdownStyleData: DropdownStyleData(
          padding: .zero,
          elevation: 2,
          maxHeight: maxHeight,
          decoration: BoxDecoration(
            color: theme?.backgroundColor,
            borderRadius: .circular(AppNum.radius),
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const .circular(40),
            thickness: WidgetStateProperty.all(2),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: .symmetric(horizontal: AppNum.spaceMedium),
          overlayColor: .resolveWith((states) {
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.pressed)) {
              return Theme.of(context).hoverColor;
            }
            return Colors.transparent;
          }),
        ),
      ),
    );
  }
}
