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

class TableTheme extends ThemeExtension<TableTheme> {
  final Color background1;
  final Color background2;
  final Color textColor;

  const TableTheme({
    required this.background1,
    required this.background2,
    required this.textColor,
  });

  @override
  ThemeExtension<TableTheme> copyWith(
      {Color? background1, Color? background2, Color? textColor}) {
    return TableTheme(
      background1: background1 ?? this.background1,
      background2: background2 ?? this.background2,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  ThemeExtension<TableTheme> lerp(
      covariant ThemeExtension<TableTheme>? other, double t) {
    if (other is! TableTheme) {
      return this;
    }
    return TableTheme(
      background1: Color.lerp(background1, other.background1, t)!,
      background2: Color.lerp(background2, other.background2, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
    );
  }
}
