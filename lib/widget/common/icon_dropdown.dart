import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:once_power/config/theme/dropdown.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/base/icon.dart';

class IconDropdown<T> extends StatelessWidget {
  const IconDropdown({
    super.key,
    this.icon,
    this.svg,
    required this.items,
    required this.value,
    this.padding,
    this.width,
    required this.onChanged,
  });

  final IconData? icon;
  final String? svg;
  final List<DropdownItem<T>> items;
  final T value;
  final EdgeInsets? padding;
  final double? width;
  final void Function(T) onChanged;

  @override
  Widget build(BuildContext context) {
    DropdownTheme? theme = Theme.of(context).extension<DropdownTheme>();
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: InkIcon(
          icon: icon,
          svg: svg,
          size: 20,
          iconSize: 28,
          color: Theme.of(context).iconTheme.color,
        ),
        items: items,
        valueListenable: ValueNotifier<T>(value),
        onChanged: (value) => onChanged(value as T),
        buttonStyleData: ButtonStyleData(
          overlayColor: .all(Colors.transparent),
        ),
        dropdownStyleData: DropdownStyleData(
          width: width ?? 112,
          padding: .zero,
          elevation: 2,
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
          // padding:
          //     padding ?? EdgeInsets.symmetric(horizontal: AppNum.spaceMedium),
          padding: .zero,
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

class InkIcon extends StatefulWidget {
  const InkIcon({
    super.key,
    this.icon,
    this.svg,
    this.size,
    this.iconSize = 32,
    this.color,
  });

  final IconData? icon;
  final String? svg;
  final double? size;
  final double? iconSize;
  final Color? color;

  @override
  State<InkIcon> createState() => _InkIconState();
}

class _InkIconState extends State<InkIcon> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (e) => setState(() => hover = true),
      onExit: (e) => setState(() => hover = false),
      child: Container(
        width: widget.iconSize,
        height: widget.iconSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: hover ? Theme.of(context).hoverColor : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: BaseIcon(
          icon: widget.icon,
          svg: widget.svg,
          size: widget.size,
          color: widget.color,
        ),
      ),
    );
  }
}
