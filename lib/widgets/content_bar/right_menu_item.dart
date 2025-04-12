import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';

final class RightMenuItem<T> extends ContextMenuItem<T> {
  final String label;
  final Color? color;

  const RightMenuItem({
    required this.label,
    this.color = Colors.black,
    super.value,
    super.onSelected,
    super.enabled,
  });

  const RightMenuItem.submenu({
    required this.label,
    this.color = Colors.black,
    required List<ContextMenuEntry> items,
    super.onSelected,
    super.enabled,
  }) : super.submenu(items: items);

  @override
  Widget builder(BuildContext context, ContextMenuState menuState,
      [FocusNode? focusNode]) {
    bool isFocused = menuState.focusedEntry == this;
    final background = Colors.white;
    final focusedBackground = Colors.grey.withValues(alpha: 0.2);
    final textStyle = TextStyle(color: color, height: 1.0, fontSize: 14.0);

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 32.0, minWidth: 100.0),
      child: Material(
        color: !enabled
            ? Colors.transparent
            : isFocused
                ? focusedBackground
                : background,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: !enabled ? null : () => handleItemSelection(context),
          canRequestFocus: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(
              label,
              maxLines: 1,
              style: textStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  @override
  String get debugLabel => "[${hashCode.toString().substring(0, 5)}] $label";
}
