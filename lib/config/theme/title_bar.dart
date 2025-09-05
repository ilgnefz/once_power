import 'package:flutter/material.dart';

class TitleBarTheme extends ThemeExtension<TitleBarTheme> {
  final TextStyle textStyle;
  final Color iconColor;

  const TitleBarTheme({required this.textStyle, required this.iconColor});

  @override
  ThemeExtension<TitleBarTheme> copyWith({
    TextStyle? textStyle,
    Color? iconColor,
  }) {
    return TitleBarTheme(
      textStyle: textStyle ?? this.textStyle,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  ThemeExtension<TitleBarTheme> lerp(
    covariant ThemeExtension<TitleBarTheme>? other,
    double t,
  ) {
    if (other is! TitleBarTheme) {
      return this;
    }
    return TitleBarTheme(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
    );
  }
}
