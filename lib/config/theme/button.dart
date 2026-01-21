import 'package:flutter/material.dart';

class CustomButtonTheme extends ThemeExtension<CustomButtonTheme> {
  final TextStyle textStyle;
  final Color backgroundColor;

  const CustomButtonTheme({
    required this.textStyle,
    required this.backgroundColor,
  });

  @override
  ThemeExtension<CustomButtonTheme> copyWith({
    TextStyle? textStyle,
    Color? backgroundColor,
  }) {
    return CustomButtonTheme(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  ThemeExtension<CustomButtonTheme> lerp(
    covariant ThemeExtension<CustomButtonTheme>? other,
    double t,
  ) {
    if (other is! CustomButtonTheme) {
      return this;
    }
    return CustomButtonTheme(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
