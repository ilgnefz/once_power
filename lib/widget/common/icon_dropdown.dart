import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
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
    required this.onChanged,
  });

  final IconData? icon;
  final String? svg;
  final List<DropdownItem<T>> items;
  final T value;
  final EdgeInsets? padding;
  final void Function(T) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: InkIcon(
          icon: icon,
          svg: svg,
          size: 18,
          color: Theme.of(context).iconTheme.color,
        ),
        items: items,
        valueListenable: ValueNotifier<T>(value),
        onChanged: (value) => onChanged(value as T),
        buttonStyleData: ButtonStyleData(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        dropdownStyleData: DropdownStyleData(
          width: 112,
          padding: EdgeInsets.zero,
          elevation: 2,
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
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: AppNum.spaceMedium),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered)) {
              return Theme.of(context).hoverColor;
            } else if (states.contains(WidgetState.focused)) {
              return Colors.transparent;
            }
            return null;
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
    this.iconSize,
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
        width: 32,
        height: 32,
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
