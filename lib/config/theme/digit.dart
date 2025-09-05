import 'package:flutter/material.dart';

class DigitTheme extends ThemeExtension<DigitTheme> {
  final Color backgroundColor;

  const DigitTheme({required this.backgroundColor});

  @override
  ThemeExtension<DigitTheme> copyWith({Color? backgroundColor}) {
    return DigitTheme(backgroundColor: backgroundColor ?? this.backgroundColor);
  }

  @override
  ThemeExtension<DigitTheme> lerp(
    covariant ThemeExtension<DigitTheme>? other,
    double t,
  ) {
    if (other is! DigitTheme) {
      return this;
    }
    return DigitTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
