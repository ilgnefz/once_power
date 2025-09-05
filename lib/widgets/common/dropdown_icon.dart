import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/base/ink_icon.dart';

class IconDropdown<T> extends StatelessWidget {
  const IconDropdown({
    super.key,
    this.items,
    this.svg,
    this.icon,
    required this.width,
    this.offset,
    this.padding,
    this.isExpanded = false,
  }) : assert(svg != null || icon != null);

  final List<DropdownMenuItem<T>>? items;
  final String? svg;
  final IconData? icon;
  final double width;
  final Offset? offset;
  final double? padding;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonStyleData: const ButtonStyleData(
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
        ),
        customButton: InkIcon(
          svg: svg,
          icon: icon,
          iconSize: 20,
          color: Theme.of(context).iconTheme.color,
        ),
        items: items,
        isExpanded: isExpanded,
        onChanged: (v) {},
        dropdownStyleData: DropdownStyleData(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          offset: offset ?? const Offset(-8, -4),
          elevation: 2,
        ),
        menuItemStyleData: MenuItemStyleData(
          height: AppNum.input,
          padding: EdgeInsets.symmetric(
            horizontal: padding ?? AppNum.paddingMedium,
          ),
        ),
      ),
    );
  }
}
