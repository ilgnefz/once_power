import 'package:flutter/material.dart';

class OverlayWidgetTheme extends ThemeExtension<OverlayWidgetTheme> {
  final Color backgroundColor;

  const OverlayWidgetTheme({required this.backgroundColor});

  @override
  ThemeExtension<OverlayWidgetTheme> copyWith({
    TextStyle? textStyle,
    Color? backgroundColor,
  }) {
    return OverlayWidgetTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  ThemeExtension<OverlayWidgetTheme> lerp(
    covariant ThemeExtension<OverlayWidgetTheme>? other,
    double t,
  ) {
    if (other is! OverlayWidgetTheme) {
      return this;
    }
    return OverlayWidgetTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
