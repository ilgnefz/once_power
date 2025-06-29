import 'package:flutter/material.dart';

class IconBoxTheme extends ThemeExtension<IconBoxTheme> {
  final Color background;
  final Color icon;

  const IconBoxTheme({
    required this.background,
    required this.icon,
  });

  @override
  ThemeExtension<IconBoxTheme> copyWith({Color? background, Color? icon}) {
    return IconBoxTheme(
      background: background ?? this.background,
      icon: icon ?? this.icon,
    );
  }

  @override
  ThemeExtension<IconBoxTheme> lerp(
      covariant ThemeExtension<IconBoxTheme>? other, double t) {
    if (other is! IconBoxTheme) {
      return this;
    }
    return IconBoxTheme(
      background: Color.lerp(background, other.background, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
    );
  }
}
