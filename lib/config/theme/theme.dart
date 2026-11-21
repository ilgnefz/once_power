import 'dart:io';
import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/color.dart';
import 'package:once_power/model/appearance.dart';

import 'set.dart';

/// 项目配色：标准 [ColorScheme] 加两个没有对应槽位的自定义色。
///
/// Flutter 的 ColorScheme 没有 icon 槽，图标色又不该借用 onSurfaceVariant
/// （那是 hint 文字用的）；NumberInput / EasyChip / IconBox 共用的容器底色也
/// 不属于 surface* 的任何一级。所以包一层，保证所有外观颜色都在 colorScheme 里装配。
class AppColorScheme {
  const AppColorScheme({
    required this.scheme,
    required this.icon,
    required this.containerSurface,
  });

  final ColorScheme scheme;
  final Color icon;
  final Color containerSurface;
}

/// 全局主题。
///
/// 颜色只有**一个来源**：`ColorScheme`。明暗各生成一套（[colorScheme]），
/// 其余 —— `scaffoldBackgroundColor`、`dividerColor` 以及 checkbox / input /
/// tabBar / text / titleBar 这些 `xxxTheme` —— 全部从它派生。所以设置页换强调
/// 色时只要换个种子，不用再回 [AppColors] 里挨个改一遍。
///
/// ```dart
/// theme: ThemeConfig.light(appearance),
/// darkTheme: ThemeConfig.dark(appearance),
/// ```
class ThemeConfig {
  static String? get font => Platform.isWindows ? 'Microsoft YaHei' : null;

  /// 由强调色种子生成 M3 配色（明暗各一套）。
  ///
  /// `primary` **就是用户选的那个颜色本身**：色盘挑了 `#FF0000`，界面上的
  /// 强调色就是 `#FF0000`。因为 `ColorScheme.fromSeed` 并不会原样保留种子——
  /// 它把种子映到 HCT 色调板上再取 tone 40（浅色）/ tone 80（深色），纯红会
  /// 变成浅色下的 `#904B40`、深色下的 `#FFB4A8`，看着根本不像自己选的色，
  /// 所以这里把 `primary` 覆盖回种子。
  ///
  /// 唯一的例外是对比度：种子跟表面拉不开（对比度 < 3，比如纯白、纯黄）时
  /// 继续用 `fromSeed` 派生的 `primary`，否则图标 / 文字在这层背景上会看不清。
  /// `onPrimary`（primary 上的文字）按种子明暗自动取黑 / 白。
  ///
  /// `primaryContainer` / `secondary` / `error` 这些仍由 `fromSeed` 派生，
  /// 与种子同一色调，所以「选中态的浅底 + 强调色」还是协调的。
  ///
  /// `fromSeed` 自带的 `surface*` 是一层暖灰（浅色 #FFFBFE、深色 #141218），
  /// 与项目里 [AppColors] 那套「按 elevation 分四级」的表面色对不上，所以
  /// 表面 / 文字 / 线换回 [AppColors] 的值。
  /// 颜色全部由 [AppearanceSettings] 提供，调用方必须传明确的值，不再用
  /// 可空参数和 AppColors 默认值兜底。[syncBackground] 打开时把控件底色也换成
  /// [background]；否则输入框 / 下拉面板 / 右键菜单 / tooltip 统一取
  /// [componentSurface]（对应的槽位分别是 surfaceContainer / surfaceContainerHighest，
  /// Material 菜单默认读 surfaceContainer）。
  static AppColorScheme colorScheme(
    Color seed,
    Brightness brightness, {
    required Color background,
    required Color componentSurface,
    required Color containerSurface,
    required Color icon,
    required Color outline,
    required bool syncBackground,
  }) {
    final bool dark = brightness == Brightness.dark;
    final Color surface = background;
    // 四个组件共用的一层表面：同步时跟随页面背景，不同步时用用户选的控件底色。
    final Color component = syncBackground ? surface : componentSurface;
    // 自定义背景可能是深色模式配浅底（或反过来），前景色得跟着背景走。
    final bool surfaceIsLight =
        ThemeData.estimateBrightnessForColor(surface) == Brightness.light;
    final ColorScheme derived = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );
    final bool accentIsReadable = _contrastRatio(seed, surface) >= 3;
    // 强调色上的文字：亮色配黑字，暗色（红、蓝、紫这类）配白字。
    final Color onAccent =
        ThemeData.estimateBrightnessForColor(seed) == Brightness.light
        ? Colors.black
        : Colors.white;
    final ColorScheme scheme = derived.copyWith(
      // 强调色：种子能看清就直接用，看不清就退回派生的 tone。
      primary: accentIsReadable ? seed : derived.primary,
      onPrimary: accentIsReadable ? onAccent : derived.onPrimary,
      // 表面：按 AppColor 的四级 elevation 填满 surface* 一族，
      // 这样 Dialog / Card / Menu 这些走 scheme 的组件也不会冒出一层暖灰。
      surface: surface,
      surfaceContainerLowest: surface,
      surfaceContainerLow: dark ? component : derived.surfaceContainerLow,
      surfaceContainer: component,
      surfaceContainerHigh: dark ? AppColors.darkDialog : AppColors.dialog,
      // dropdown 面板 / EasyButton 底色，和输入框、菜单、tooltip 同一个值。
      surfaceContainerHighest: component,
      // 前景：主文字 / 次级文字（Material 用它渲染 hint、说明文字）。
      onSurface: surfaceIsLight ? AppColors.text : AppColors.darkText,
      onSurfaceVariant: surfaceIsLight
          ? AppColors.textHint
          : AppColors.darkTextHint,
      // 线：输入框 / dropdown 的描边（分隔线走 outlineVariant）。
      outline: outline,
      outlineVariant: dark ? AppColors.darkDivider : AppColors.divider,
    );
    return AppColorScheme(
      scheme: scheme,
      icon: icon,
      containerSurface: containerSurface,
    );
  }

  /// WCAG 对比度：`(亮的更亮 + 0.05) / (暗的更暗 + 0.05)`，范围 1~21。
  static double _contrastRatio(Color a, Color b) {
    final double la = a.computeLuminance();
    final double lb = b.computeLuminance();
    return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
  }

  /// 只接收一份外观快照，明暗各自取对应字段；所有颜色都是明确值。
  static ThemeData light(AppearanceSettings appearance) =>
      _build(appearance, Brightness.light);

  static ThemeData dark(AppearanceSettings appearance) =>
      _build(appearance, Brightness.dark);

  static ThemeData _build(
    AppearanceSettings appearance,
    Brightness brightness,
  ) {
    final bool syncBackground = appearance.syncFor(brightness);
    final AppColorScheme colors = colorScheme(
      appearance.seedFor(brightness),
      brightness,
      background: appearance.backgroundFor(brightness),
      componentSurface: appearance.componentSurfaceFor(brightness),
      containerSurface: appearance.containerSurfaceFor(brightness),
      icon: appearance.iconFor(brightness),
      outline: appearance.outlineFor(brightness),
      syncBackground: syncBackground,
    );
    final ColorScheme scheme = colors.scheme;
    return ThemeData(
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: font,
      scaffoldBackgroundColor: scheme.surface,
      dividerColor: scheme.outlineVariant,
      checkboxTheme: AppCheckboxTheme.of(scheme),
      iconTheme: AppIconTheme.of(colors),
      inputDecorationTheme: AppInputTheme.of(scheme),
      tabBarTheme: AppTabBarTheme.of(scheme),
      textTheme: AppTextTheme.of(scheme),
      tooltipTheme: AppTooltipTheme.of(scheme),
      extensions: [
        AppEasyButtonTheme.of(scheme),
        AppEasyChipTheme.of(colors),
        AppIconBoxTheme.of(colors),
        AppContainerSurfaceTheme.of(colors),
        AppTitleBarTheme.of(scheme),
      ],
    );
  }
}
