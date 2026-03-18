import 'package:flutter/material.dart';

class DirectiveTheme extends ThemeExtension<DirectiveTheme> {
  final WidgetStateColor defaultColor;
  final WidgetStateColor heightLight;

  const DirectiveTheme({required this.defaultColor, required this.heightLight});

  @override
  ThemeExtension<DirectiveTheme> copyWith({
    WidgetStateColor? defaultColor,
    WidgetStateColor? heightLight,
  }) {
    return DirectiveTheme(
      defaultColor: defaultColor ?? this.defaultColor,
      heightLight: heightLight ?? this.heightLight,
    );
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
      defaultColor: _lerpWidgetStateColor(defaultColor, other.defaultColor, t),
      heightLight: _lerpWidgetStateColor(heightLight, other.heightLight, t),
    );
  }

  static WidgetStateColor _lerpWidgetStateColor(
    WidgetStateColor a,
    WidgetStateColor b,
    double t,
  ) {
    return WidgetStateColor.resolveWith((states) {
      return Color.lerp(a.resolve(states), b.resolve(states), t)!;
    });
  }
}
