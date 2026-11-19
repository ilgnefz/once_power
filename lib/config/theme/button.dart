import 'package:material_ui/material_ui.dart';

class EasyButtonTheme extends ThemeExtension<EasyButtonTheme> {
  final TextStyle textStyle;
  final Color backgroundColor;

  const EasyButtonTheme({
    required this.textStyle,
    required this.backgroundColor,
  });

  @override
  ThemeExtension<EasyButtonTheme> copyWith({
    TextStyle? textStyle,
    Color? backgroundColor,
  }) {
    return EasyButtonTheme(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  ThemeExtension<EasyButtonTheme> lerp(
    covariant ThemeExtension<EasyButtonTheme>? other,
    double t,
  ) {
    if (other is! EasyButtonTheme) {
      return this;
    }
    return EasyButtonTheme(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
