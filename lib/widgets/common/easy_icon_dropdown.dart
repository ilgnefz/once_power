import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/widgets/common/easy_icon.dart';

class EasyIconDropdown<T> extends StatelessWidget {
  const EasyIconDropdown({
    super.key,
    this.items,
    this.svg,
    this.icon,
    required this.width,
    this.offset,
    this.padding,
  }) : assert(svg != null || icon != null);

  final List<DropdownMenuItem<T>>? items;
  final String? svg;
  final IconData? icon;
  final double width;
  final Offset? offset;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonStyleData: const ButtonStyleData(
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
        ),
        customButton: EasyIcon(
          svg: svg,
          icon: icon,
          iconSize: icon != null ? AppNum.defaultIconS : AppNum.dropdownIconS,
          color: AppColors.icon,
        ),
        items: items,
        onChanged: (v) {},
        dropdownStyleData: DropdownStyleData(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          offset: offset ?? const Offset(-8, -4),
          elevation: 2,
        ),
        menuItemStyleData: MenuItemStyleData(
          height: AppNum.dropdownMenuItemH,
          padding:
              EdgeInsets.symmetric(horizontal: padding ?? AppNum.fileCardP),
        ),
      ),
    );
  }
}
