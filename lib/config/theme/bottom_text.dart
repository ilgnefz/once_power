import 'package:flutter/material.dart';

class BottomTextTheme extends ThemeExtension<BottomTextTheme> {
  final TextStyle textStyle;

  const BottomTextTheme({required this.textStyle});

  @override
  ThemeExtension<BottomTextTheme> copyWith({TextStyle? textStyle}) {
    return BottomTextTheme(textStyle: textStyle ?? this.textStyle);
  }

  @override
  ThemeExtension<BottomTextTheme> lerp(
    covariant ThemeExtension<BottomTextTheme>? other,
    double t,
  ) {
    if (other is! BottomTextTheme) {
      return this;
    }
    return BottomTextTheme(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
