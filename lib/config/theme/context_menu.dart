import 'package:flutter/material.dart';

class ContextMenuTheme extends ThemeExtension<ContextMenuTheme> {
  final Color backgroundColor;

  const ContextMenuTheme({required this.backgroundColor});

  @override
  ThemeExtension<ContextMenuTheme> copyWith({
    TextStyle? textStyle,
    Color? backgroundColor,
  }) {
    return ContextMenuTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  ThemeExtension<ContextMenuTheme> lerp(
    covariant ThemeExtension<ContextMenuTheme>? other,
    double t,
  ) {
    if (other is! ContextMenuTheme) {
      return this;
    }
    return ContextMenuTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
