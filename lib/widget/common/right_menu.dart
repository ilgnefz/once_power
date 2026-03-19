import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:once_power/config/theme/context_menu.dart';
import 'package:once_power/config/theme/theme.dart';

final class RightMenuItem extends ContextMenuItem<dynamic> {
  final String label;
  final Color? color;

  const RightMenuItem({
    required this.label,
    this.color,
    super.value,
    super.onSelected,
    super.enabled,
  });

  const RightMenuItem.submenu({
    required this.label,
    this.color,
    required List<ContextMenuEntry<dynamic>> items,
    super.onSelected,
    super.enabled,
  }) : super.submenu(items: items);

  @override
  Widget builder(
    BuildContext context,
    ContextMenuState<dynamic> menuState, [
    FocusNode? focusNode,
  ]) {
    final ThemeData theme = Theme.of(context);
    bool isFocused = menuState.focusedEntry == this;
    final Color background = theme
        .extension<OverlayWidgetTheme>()!
        .backgroundColor;
    final Color focusedBackground = Colors.grey.withValues(alpha: 0.2);
    final TextStyle textStyle = TextStyle(
      color: color ?? theme.textTheme.labelMedium?.color,
      height: 1.0,
      fontSize: 14.0,
      fontFamily: defaultFont,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 32.0, minWidth: 100.0),
      child: Material(
        color: !enabled
            ? null
            : isFocused
            ? focusedBackground
            : background,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          onTap: enabled ? () => handleItemSelection(context, menuState) : null,
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
