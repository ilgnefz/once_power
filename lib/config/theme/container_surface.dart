import 'package:material_ui/material_ui.dart';

/// NumberInput / EasyChip / IconBox 共用的容器底色。
///
/// 这三者不属于任何标准 ColorScheme 槽位，故单独用一个 ThemeExtension 承载，
/// widget 通过 `Theme.of(context).extension<ContainerSurfaceTheme>()` 读取。
class ContainerSurfaceTheme extends ThemeExtension<ContainerSurfaceTheme> {
  const ContainerSurfaceTheme({required this.color});

  final Color color;

  @override
  ThemeExtension<ContainerSurfaceTheme> copyWith({Color? color}) =>
      ContainerSurfaceTheme(color: color ?? this.color);

  @override
  ThemeExtension<ContainerSurfaceTheme> lerp(
    covariant ThemeExtension<ContainerSurfaceTheme>? other,
    double t,
  ) {
    if (other is! ContainerSurfaceTheme) return this;
    return ContainerSurfaceTheme(
      color: Color.lerp(color, other.color, t)!,
    );
  }
}
