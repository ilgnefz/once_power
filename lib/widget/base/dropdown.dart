import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/theme/theme.dart';
import 'package:once_power/constant/number.dart';

class const EasyTextDropdown<T extends Object>({
  super.key,
  required final T value,
  required final List<TextDropdownItem<T>> items,
  final double width = 120.0,
  final ValueChanged<T>? onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double num = 10, gap = 2;
    return TextDropdown<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      textStyle: TextStyle(fontSize: 14, fontFamily: ThemeConfig.font),
      width: width,
      height: AppNumber.widgetHeight,
      maxPanelHeight: AppNumber.widgetHeight * num + gap * (num - 1) + 8,
      itemGap: gap,
      radius: AppNumber.radius,
      borderColor: Theme.of(context).inputDecorationTheme.outlineBorder!.color,
      style: DropdownStyle.of(context).copyWith(
        // 与输入框 / 菜单 / tooltip 共用控件底色（同步时跟随页面背景）。
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderColor: Theme.of(context)
            .inputDecorationTheme
            .outlineBorder!
            .color,
        itemHeight: AppNumber.widgetHeight,
        itemPadding: .symmetric(horizontal: AppNumber.paddingMedium),
        fieldPadding: .symmetric(horizontal: AppNumber.paddingMedium),
        // radius: AppNumber.radius,
        // borderColor: Theme.of(context).inputDecorationTheme.outlineBorder!.color,
      ),
    );
  }
}
