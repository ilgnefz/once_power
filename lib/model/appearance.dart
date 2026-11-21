import 'dart:ui' show Brightness, Color;

import 'package:once_power/enmu/app.dart';

/// 外观设置快照：把主题页用到的偏好收在一个类里，只需 watch 一次。
///
/// 写操作仍走各自 provider 的 notifier，这里只做只读聚合。
class AppearanceSettings {
  const AppearanceSettings({
    required this.theme,
    required this.lightSeed,
    required this.darkSeed,
    required this.lightBackground,
    required this.darkBackground,
    required this.lightComponentSurface,
    required this.darkComponentSurface,
    required this.lightContainerSurface,
    required this.darkContainerSurface,
    required this.lightIcon,
    required this.darkIcon,
    required this.lightOutline,
    required this.darkOutline,
    required this.lightSync,
    required this.darkSync,
    required this.lightTransparent,
    required this.darkTransparent,
  });

  final ThemeType theme;
  final int lightSeed;
  final int darkSeed;
  final int lightBackground;
  final int darkBackground;
  final int lightComponentSurface;
  final int darkComponentSurface;
  final int lightContainerSurface;
  final int darkContainerSurface;
  final int lightIcon;
  final int darkIcon;
  final int lightOutline;
  final int darkOutline;
  final bool lightSync;
  final bool darkSync;
  final bool lightTransparent;
  final bool darkTransparent;

  Color get lightSeedColor => Color(lightSeed);
  Color get darkSeedColor => Color(darkSeed);
  Color get lightBackgroundColor => Color(lightBackground);
  Color get darkBackgroundColor => Color(darkBackground);
  Color get lightComponentSurfaceColor => Color(lightComponentSurface);
  Color get darkComponentSurfaceColor => Color(darkComponentSurface);
  Color get lightContainerSurfaceColor => Color(lightContainerSurface);
  Color get darkContainerSurfaceColor => Color(darkContainerSurface);
  Color get lightIconColor => Color(lightIcon);
  Color get darkIconColor => Color(darkIcon);
  Color get lightOutlineColor => Color(lightOutline);
  Color get darkOutlineColor => Color(darkOutline);

  /// 按明暗取当前模式下生效的值，构建主题时不用再写一遍三元判断。
  Color seedFor(Brightness brightness) =>
      brightness == Brightness.dark ? darkSeedColor : lightSeedColor;
  Color backgroundFor(Brightness brightness) =>
      brightness == Brightness.dark ? darkBackgroundColor : lightBackgroundColor;
  Color componentSurfaceFor(Brightness brightness) => brightness == Brightness.dark
      ? darkComponentSurfaceColor
      : lightComponentSurfaceColor;
  Color containerSurfaceFor(Brightness brightness) => brightness == Brightness.dark
      ? darkContainerSurfaceColor
      : lightContainerSurfaceColor;
  Color iconFor(Brightness brightness) =>
      brightness == Brightness.dark ? darkIconColor : lightIconColor;
  Color outlineFor(Brightness brightness) =>
      brightness == Brightness.dark ? darkOutlineColor : lightOutlineColor;
  bool syncFor(Brightness brightness) =>
      brightness == Brightness.dark ? darkSync : lightSync;
}
