import 'package:flutter/material.dart';

class TableTheme extends ThemeExtension<TableTheme> {
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color textColor;

  const TableTheme({
    required this.backgroundColor1,
    required this.backgroundColor2,
    required this.textColor,
  });

  @override
  ThemeExtension<TableTheme> copyWith({
    Color? backgroundColor1,
    Color? backgroundColor2,
    Color? textColor,
  }) {
    return TableTheme(
      backgroundColor1: backgroundColor1 ?? this.backgroundColor1,
      backgroundColor2: backgroundColor2 ?? this.backgroundColor2,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  ThemeExtension<TableTheme> lerp(
    covariant ThemeExtension<TableTheme>? other,
    double t,
  ) {
    if (other is! TableTheme) {
      return this;
    }
    return TableTheme(
      backgroundColor1: Color.lerp(
        backgroundColor1,
        other.backgroundColor1,
        t,
      )!,
      backgroundColor2: Color.lerp(
        backgroundColor2,
        other.backgroundColor2,
        t,
      )!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
    );
  }
}
