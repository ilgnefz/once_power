import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/dropdown.dart';
import 'package:once_power/widget/base/switch.dart';
import 'package:once_power/widget/base/text.dart';

class SettingMenu<T extends Object> extends StatelessWidget {
  const SettingMenu({super.key, required this.label, required this.action});

  SettingMenu.toggle({
    super.key,
    required this.label,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) : action = EasySwitch(value: value, onChanged: onChanged);

  SettingMenu.dropdown({
    super.key,
    required this.label,
    required T value,
    required List<TextDropdownItem<T>> items,
    double width = 120.0,
    ValueChanged<T>? onChanged,
  }) : action = EasyTextDropdown<T>(
         value: value,
         items: items,
         onChanged: onChanged,
         width: width,
       );

  final String label;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppNumber.widgetHeight,
      alignment: .center,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        spacing: AppNumber.space,
        children: [BaseText(label), action],
      ),
    );
  }
}
