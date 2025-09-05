import 'package:flutter/material.dart';

class BtnTheme extends ThemeExtension<BtnTheme> {
  final TextStyle textStyle;
  final Color backgroundColor;

  const BtnTheme({required this.textStyle, required this.backgroundColor});

  @override
  ThemeExtension<BtnTheme> copyWith({
    TextStyle? textStyle,
    Color? backgroundColor,
  }) {
    return BtnTheme(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  ThemeExtension<BtnTheme> lerp(
    covariant ThemeExtension<BtnTheme>? other,
    double t,
  ) {
    if (other is! BtnTheme) {
      return this;
    }
    return BtnTheme(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
