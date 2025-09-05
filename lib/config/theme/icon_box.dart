import 'package:flutter/material.dart';

class IconBoxTheme extends ThemeExtension<IconBoxTheme> {
  final Color backgroundColor;
  final Color iconColor;

  const IconBoxTheme({required this.backgroundColor, required this.iconColor});

  @override
  ThemeExtension<IconBoxTheme> copyWith({
    Color? backgroundColor,
    Color? iconColor,
  }) {
    return IconBoxTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  ThemeExtension<IconBoxTheme> lerp(
    covariant ThemeExtension<IconBoxTheme>? other,
    double t,
  ) {
    if (other is! IconBoxTheme) {
      return this;
    }
    return IconBoxTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
    );
  }
}
