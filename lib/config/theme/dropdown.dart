import 'package:flutter/material.dart';

class DropdownTheme extends ThemeExtension<DropdownTheme> {
  final TextStyle textStyle;
  final Color menuBackgroundColor;
  final Color backgroundColor;

  const DropdownTheme({
    required this.textStyle,
    required this.menuBackgroundColor,
    required this.backgroundColor,
  });

  @override
  ThemeExtension<DropdownTheme> copyWith({
    TextStyle? textStyle,
    Color? menuBackgroundColor,
    Color? backgroundColor,
  }) {
    return DropdownTheme(
      textStyle: textStyle ?? this.textStyle,
      menuBackgroundColor: menuBackgroundColor ?? this.menuBackgroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  ThemeExtension<DropdownTheme> lerp(
    covariant ThemeExtension<DropdownTheme>? other,
    double t,
  ) {
    if (other is! DropdownTheme) {
      return this;
    }
    return DropdownTheme(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      menuBackgroundColor: Color.lerp(
        backgroundColor,
        other.backgroundColor,
        t,
      )!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
