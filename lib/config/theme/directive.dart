import 'package:flutter/material.dart';

class DirectiveTheme extends ThemeExtension<DirectiveTheme> {
  final Color hoverColor;

  const DirectiveTheme({required this.hoverColor});

  @override
  ThemeExtension<DirectiveTheme> copyWith({Color? hoverColor}) {
    return DirectiveTheme(hoverColor: hoverColor ?? this.hoverColor);
  }

  @override
  ThemeExtension<DirectiveTheme> lerp(
    covariant ThemeExtension<DirectiveTheme>? other,
    double t,
  ) {
    if (other is! DirectiveTheme) {
      return this;
    }
    return DirectiveTheme(
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
    );
  }
}
