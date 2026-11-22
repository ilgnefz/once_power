import 'package:material_ui/material_ui.dart';

class DotTheme extends ThemeExtension<DotTheme> {
  final Color color;
  final Color selectedColor;

  const DotTheme({required this.color, required this.selectedColor});

  @override
  ThemeExtension<DotTheme> copyWith({Color? color, Color? selectedColor}) {
    return DotTheme(
      color: color ?? this.color,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  @override
  ThemeExtension<DotTheme> lerp(
    covariant ThemeExtension<DotTheme>? other,
    double t,
  ) {
    if (other is! DotTheme) {
      return this;
    }
    return DotTheme(
      color: Color.lerp(color, other.color, t)!,
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t)!,
    );
  }
}
