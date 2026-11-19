import 'dart:io';
import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/color.dart';

import 'set.dart';

/// 全局主题。
///
/// 颜色只有**一个来源**：`ColorScheme`。明暗各生成一套（[colorScheme]），
/// 其余 —— `scaffoldBackgroundColor`、`dividerColor` 以及 checkbox / input /
/// tabBar / text / titleBar 这些 `xxxTheme` —— 全部从它派生。所以设置页换强调
/// 色时只要换个种子，不用再回 [AppColors] 里挨个改一遍。
///
/// ```dart
/// theme: ThemeConfig.light(seed),
/// darkTheme: ThemeConfig.dark(seed),
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
  static ColorScheme colorScheme(Color seed, Brightness brightness) {
    final bool dark = brightness == Brightness.dark;
    final Color surface = dark
        ? AppColors.backgroundDark
        : AppColors.background;
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
    return derived.copyWith(
      // 强调色：种子能看清就直接用，看不清就退回派生的 tone。
      primary: accentIsReadable ? seed : derived.primary,
      onPrimary: accentIsReadable ? onAccent : derived.onPrimary,
      // 表面：按 AppColor 的四级 elevation 填满 surface* 一族，
      // 这样 Dialog / Card / Menu 这些走 scheme 的组件也不会冒出一层暖灰。
      surface: surface,
      surfaceContainerLowest: surface,
      surfaceContainer: dark ? AppColors.inputDark : AppColors.input,
      surfaceContainerHigh: dark
          ? AppColors.overlayWidgetDark
          : AppColors.overlayWidget,
      surfaceContainerHighest: dark
          ? AppColors.dropdownDark
          : AppColors.dropdown,
      // 前景：主文字 / 次级文字（Material 用它渲染 hint、说明文字）。
      onSurface: dark ? AppColors.textDark : AppColors.text,
      onSurfaceVariant: dark ? AppColors.textHintDark : AppColors.textHint,
      // 线：输入框描边 / 分隔线。
      outline: dark ? AppColors.inputBorderDark : AppColors.inputBorder,
      outlineVariant: dark ? AppColors.dividerDark : AppColors.divider,
    );
  }

  /// WCAG 对比度：`(亮的更亮 + 0.05) / (暗的更暗 + 0.05)`，范围 1~21。
  static double _contrastRatio(Color a, Color b) {
    final double la = a.computeLuminance();
    final double lb = b.computeLuminance();
    return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
  }

  static ThemeData light(Color seed) => _build(seed, Brightness.light);

  static ThemeData dark(Color seed) => _build(seed, Brightness.dark);

  static ThemeData _build(Color seed, Brightness brightness) {
    final ColorScheme scheme = colorScheme(seed, brightness);
    return ThemeData(
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: font,
      scaffoldBackgroundColor: scheme.surface,
      dividerColor: scheme.outlineVariant,
      checkboxTheme: AppCheckboxTheme.of(scheme),
      iconTheme: AppIconTheme.of(brightness),
      inputDecorationTheme: AppInputTheme.of(scheme),
      tabBarTheme: AppTabBarTheme.of(scheme),
      textTheme: AppTextTheme.of(scheme),
      extensions: [
        // 其余扩展主题（BottomText / CustomButton / OverlayWidget / Directive /
        // Dropdown / EasyChip / IconBox / Table）就加在这里，签名同样收 scheme。
        AppEasyButtonTheme.of(scheme),
        AppEasyChipTheme.of(scheme),
        AppIconBoxTheme.of(scheme),
        AppTitleBarTheme.of(scheme),
      ],
    );
  }
}
