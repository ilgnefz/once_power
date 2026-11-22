import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/theme/theme.dart';
import 'package:once_power/constant/color.dart';

import 'button.dart';
import 'chip.dart';
import 'container_surface.dart';
import 'dot.dart';
import 'icon_box.dart';
import 'title_bar.dart';

String? _font = ThemeConfig.font;

TextStyle _textStyle = TextStyle(fontSize: 14, fontFamily: ThemeConfig.font);

/// TabBar 的 InkWell 反馈：hover / pressed 完全透明；focused 返回 null，
/// 让 InkWell 保留键盘焦点提示。配合 NoSplash.splashFactory 彻底去掉
/// 圆角方块与点击涟漪，hover 反馈改由标签文字变色承担。
final WidgetStateProperty<Color?> _tabOverlayColor =
    WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) =>
          states.contains(WidgetState.focused) ? null : Colors.transparent,
    );

/* ---------- Office Widget Theme ----------*/
//
// 每个 `of` 都从 [ColorScheme] 取色：强调色（primary）、表面（surface*）、
// 前景（onSurface / onSurfaceVariant）、线（outline / outlineVariant）。
// 这样设置页换主题色时，明暗两套一起跟着变，不用再分 light() / dark() 两份
// 手写颜色。

class AppCheckboxTheme {
  static CheckboxThemeData of(ColorScheme scheme) => CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected) ? scheme.primary : null,
    ),
    // 描边刻意用纯黑 / 纯白，不跟表面色走：未选中的方框靠这条硬边才看得清。
    side: BorderSide(
      width: 1,
      color: scheme.brightness == Brightness.dark ? Colors.white : Colors.black,
    ),
  );
}

class AppIconTheme {
  static IconThemeData of(AppColorScheme colors) =>
      IconThemeData(color: colors.icon);
}

class AppInputTheme {
  static InputDecorationTheme of(ColorScheme scheme) {
    return InputDecorationTheme(
      // surfaceContainer 就是 AppColor 里给输入框定的那层表面。
      fillColor: scheme.surfaceContainer,
      hintStyle: _textStyle.copyWith(color: scheme.onSurfaceVariant),
      // 输入框 / dropdown 的描边一律 1px，颜色来自 ColorScheme.outline，
      // 这样设置页选的边框色在深色模式下也看得见。
      outlineBorder: BorderSide(color: scheme.outline, width: 1),
    );
  }
}

class AppTabBarTheme {
  static TabBarThemeData of(ColorScheme scheme) => TabBarThemeData(
    labelStyle: _textStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: scheme.primary,
    ),
    unselectedLabelStyle: _textStyle.copyWith(
      color: scheme.onSurface,
      fontWeight: .normal,
    ),
    indicator: _indicator(scheme.primary),
    indicatorSize: TabBarIndicatorSize.tab,
    // indicatorSize.tab 默认走 linear；显式指定 elastic 才能保留切换时
    // 短-长-短的拉伸动画（_IndicatorPainter._applyElasticEffect）。
    indicatorAnimation: TabIndicatorAnimation.elastic,
    // TabBar 与 TabBarView 之间那条线是 M3 TabBar 自带的 divider（不是 Border），
    // 透明色 + 高度 0 双保险，_TabBarState 就不会挂 _DividerPainter。
    dividerColor: Colors.transparent,
    dividerHeight: 0,
    // 默认 kTabLabelPadding 左右各 16，80px 的 tab 只剩 48px 给文字，
    // 英文 Advanced / Organize 会被 fade 截断，空白却还在。
    labelPadding: EdgeInsets.zero,
    overlayColor: _tabOverlayColor,
    splashFactory: NoSplash.splashFactory,
  );

  /// 四角全圆的胶囊指示条，厚度与 M3 默认一致（label 指示器为 3.0）。
  ///
  /// M3 默认的 [UnderlineTabIndicator] 只给 topLeft / topRight 加圆角，且紧贴
  /// TabBar 底边，看起来像被削掉下半截。这里用 insets.bottom 把条抬高，四个
  /// 角的圆角才都露得出来；半径由 RRect 自动 clamp 到条高的一半，两端成半圆。
  static UnderlineTabIndicator _indicator(Color color) => UnderlineTabIndicator(
    borderSide: BorderSide(width: 3, color: color),
    borderRadius: BorderRadius.circular(3),
    insets: const EdgeInsets.only(left: 32, right: 32, bottom: 4),
  );
}

class AppTextTheme {
  static TextTheme of(ColorScheme scheme) => TextTheme(
    titleMedium: _textStyle.copyWith(
      fontSize: 16.0,
      fontWeight: .bold,
      color: scheme.onSurface,
    ),
    bodyMedium: _textStyle.copyWith(color: scheme.onSurface),
    bodySmall: _textStyle.copyWith(fontSize: 13.0, color: scheme.onSurface),
    titleSmall: _textStyle.copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: scheme.onSurfaceVariant,
    ),
    labelMedium: _textStyle.copyWith(color: scheme.onSurfaceVariant),
  );
}

/* ---------- Custom Widget Theme ----------*/
class AppDotTheme {
  static DotTheme of(AppColorScheme colors) => DotTheme(
    color: colors.scheme.primary.withValues(alpha: .5),
    selectedColor: colors.scheme.primary,
  );
}

class AppEasyButtonTheme {
  static EasyButtonTheme of(ColorScheme scheme) => EasyButtonTheme(
    textStyle: _textStyle.copyWith(color: scheme.primary),
    backgroundColor: scheme.surfaceContainerHighest,
  );
}

class AppEasyChipTheme {
  static EasyChipTheme of(AppColorScheme colors) => EasyChipTheme(
    textStyle: _textStyle.copyWith(
      color: colors.scheme.brightness == Brightness.dark
          ? AppColors.darkEasyChipText
          : AppColors.easyChipText,
    ),
    selectTextStyle: _textStyle.copyWith(color: Colors.white),
    backgroundColor: colors.containerSurface,
    selectBackgroundColor: colors.scheme.primary,
  );
}

class AppIconBoxTheme {
  static IconBoxTheme of(AppColorScheme colors) => IconBoxTheme(
    backgroundColor: colors.containerSurface,
    iconColor: colors.icon,
  );
}

class AppContainerSurfaceTheme {
  static ContainerSurfaceTheme of(AppColorScheme colors) =>
      ContainerSurfaceTheme(color: colors.containerSurface);
}

class AppTitleBarTheme {
  static TitleBarTheme of(ColorScheme scheme) => TitleBarTheme(
    textStyle: _textStyle.copyWith(
      fontSize: 13,
      color: scheme.primary,
      fontWeight: FontWeight.w600,
      fontFamily: _font,
    ),
    iconColor: scheme.brightness == Brightness.dark
        ? AppColors.titleBarDark
        : AppColors.titleBar,
  );
}

/// Tooltip 用官方 [TooltipThemeData] 承载配色，SmartTooltip 不读官方主题，
/// 由 EasyTooltip 从 TooltipTheme.of(context) 取出后逐项传给它。
class AppTooltipTheme {
  static TooltipThemeData of(ColorScheme scheme) {
    // 气泡底色与输入框 / 下拉面板 / 右键菜单共用 surfaceContainer：同步时跟随
    // 页面背景，不同步时取用户选的控件底色。文字统一走 bodySmall，颜色随 onSurface。
    return TooltipThemeData(
      decoration: BoxDecoration(color: scheme.surfaceContainer),
      textStyle: AppTextTheme.of(scheme).bodySmall,
    );
  }
}
