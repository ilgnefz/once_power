import 'package:flutter/material.dart';

class DirectiveTheme extends ThemeExtension<DirectiveTheme> {
  final Color hoverColor;
  final WidgetStateColor defaultColor;
  final WidgetStateColor heightLight;

  const DirectiveTheme({
    required this.hoverColor,
    required this.defaultColor,
    required this.heightLight,
  });

  @override
  ThemeExtension<DirectiveTheme> copyWith({
    Color? hoverColor,
    WidgetStateColor? defaultColor,
    WidgetStateColor? heightLight,
  }) {
    return DirectiveTheme(
      hoverColor: hoverColor ?? this.hoverColor,
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
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
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
