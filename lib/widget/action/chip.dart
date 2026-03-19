import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/chip.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/provider/setting.dart';

class EasyChip extends StatelessWidget {
  const EasyChip({
    super.key,
    required this.label,
    required this.selected,
    this.fontSize = 14,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final double fontSize;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final EasyChipTheme? theme = Theme.of(context).extension<EasyChipTheme>();
    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8));
    Color? bgColor = selected
        ? theme?.selectBackgroundColor
        : theme?.backgroundColor;
    TextStyle? style = selected ? theme?.selectTextStyle : theme?.textStyle;

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        bool shadow = ref.watch(themeSettingProvider.select((e) => e.shadow));
        return Material(
          borderRadius: borderRadius,
          elevation: shadow ? 1 : 0,
          child: child,
        );
      },
      child: Ink(
        decoration: BoxDecoration(color: bgColor, borderRadius: borderRadius),
        child: InkWell(
          onTap: onTap,
          mouseCursor: SystemMouseCursors.click,
          borderRadius: borderRadius,
          child: Container(
            height: AppNum.widgetHeight,
            padding: const EdgeInsets.symmetric(horizontal: AppNum.padding),
            alignment: Alignment.center,
            decoration: BoxDecoration(),
            child: Text(label, style: style),
          ),
        ),
      ),
    );
  }
}
