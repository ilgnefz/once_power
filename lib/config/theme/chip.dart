import 'package:flutter/material.dart';

class EasyChipTheme extends ThemeExtension<EasyChipTheme> {
  final TextStyle textStyle;
  final TextStyle selectTextStyle;
  final TextStyle diableTextStyle;
  final Color backgroundColor;
  final Color selectBackgroundColor;
  final Color disableBackgroundColor;

  const EasyChipTheme({
    required this.textStyle,
    required this.selectTextStyle,
    required this.diableTextStyle,
    required this.backgroundColor,
    required this.selectBackgroundColor,
    required this.disableBackgroundColor,
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
      diableTextStyle: diableTextStyle ?? this.diableTextStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectBackgroundColor:
          selectBackgroundColor ?? this.selectBackgroundColor,
      disableBackgroundColor:
          disableBackgroundColor ?? this.disableBackgroundColor,
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
      diableTextStyle: TextStyle.lerp(
        diableTextStyle,
        other.diableTextStyle,
        t,
      )!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      selectBackgroundColor: Color.lerp(
        selectBackgroundColor,
        other.selectBackgroundColor,
        t,
      )!,
      disableBackgroundColor: Color.lerp(
        disableBackgroundColor,
        other.disableBackgroundColor,
        t,
      )!,
    );
  }
}
