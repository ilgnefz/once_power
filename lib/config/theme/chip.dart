import 'package:flutter/material.dart';

class EasyChipTheme extends ThemeExtension<EasyChipTheme> {
  final TextStyle textStyle;
  final TextStyle selectTextStyle;
  final Color backgroundColor;
  final Color selectBackgroundColor;

  const EasyChipTheme({
    required this.textStyle,
    required this.selectTextStyle,
    required this.backgroundColor,
    required this.selectBackgroundColor,
  });

  @override
  ThemeExtension<EasyChipTheme> copyWith({
    TextStyle? textStyle,
    TextStyle? selectTextStyle,
    TextStyle? diableTextStyle,
    Color? backgroundColor,
    Color? selectBackgroundColor,
    Color? disableBackgroundColor,
  }) {
    return EasyChipTheme(
      textStyle: textStyle ?? this.textStyle,
      selectTextStyle: selectTextStyle ?? this.selectTextStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectBackgroundColor:
          selectBackgroundColor ?? this.selectBackgroundColor,
    );
  }

  @override
  ThemeExtension<EasyChipTheme> lerp(
    covariant ThemeExtension<EasyChipTheme>? other,
    double t,
  ) {
    if (other is! EasyChipTheme) {
      return this;
    }
    return EasyChipTheme(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      selectTextStyle: TextStyle.lerp(
        selectTextStyle,
        other.selectTextStyle,
        t,
      )!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      selectBackgroundColor: Color.lerp(
        selectBackgroundColor,
        other.selectBackgroundColor,
        t,
      )!,
    );
  }
}
