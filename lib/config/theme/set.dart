import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/theme/theme.dart';
import 'package:once_power/constant/color.dart';

import 'button.dart';
import 'chip.dart';
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
  static IconThemeData of(Brightness brightness) => IconThemeData(
    color: brightness == Brightness.dark ? AppColors.iconDark : AppColors.icon,
  );
}

class AppInputTheme {
  static InputDecorationTheme of(ColorScheme scheme) {
    final bool dark = scheme.brightness == Brightness.dark;
    return InputDecorationTheme(
      // surfaceContainer 就是 AppColor 里给输入框定的那层表面。
      fillColor: scheme.surfaceContainer,
      hintStyle: _textStyle.copyWith(color: scheme.onSurfaceVariant),
      // 深色下不画描边（靠表面色分层），浅色下 1px 发丝线。
      outlineBorder: BorderSide(color: scheme.outline, width: dark ? 0 : 1),
    );
  }
}

class AppTabBarTheme {
  static TabBarThemeData of(ColorScheme scheme) => TabBarThemeData(
    labelStyle: _textStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: scheme.primary,
    ),
    unselectedLabelStyle: _textStyle.copyWith(color: scheme.onSurface),
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
    bodyMedium: _textStyle.copyWith(color: scheme.onSurface),
    bodySmall: _textStyle.copyWith(color: scheme.onSurface, fontSize: 13.0),
  );
}

/* ---------- Custom Widget Theme ----------*/
class AppEasyButtonTheme {
  static EasyButtonTheme of(ColorScheme scheme) => EasyButtonTheme(
    textStyle: _textStyle.copyWith(color: scheme.primary),
    // 跟 M3 ElevatedButton 默认背景一致（_ElevatedButtonDefaultsM3）；
    // 上面的 primary 文字正好对应它的 foregroundColor。
    backgroundColor: scheme.surfaceContainerLow,
  );
}

class AppEasyChipTheme {
  static EasyChipTheme of(ColorScheme scheme) => EasyChipTheme(
    textStyle: _textStyle.copyWith(
      color: scheme.brightness == Brightness.dark
          ? AppColors.easyChipTextDark
          : AppColors.easyChipText,
    ),
    selectTextStyle: _textStyle.copyWith(color: Colors.white),
    backgroundColor: scheme.brightness == Brightness.dark
        ? AppColors.easyChipDark
        : AppColors.easyChip,
    selectBackgroundColor: scheme.brightness == Brightness.dark
        ? scheme.primary
        : scheme.primary,
  );
}

class AppIconBoxTheme {
  static IconBoxTheme of(ColorScheme scheme) => IconBoxTheme(
    backgroundColor: scheme.brightness == Brightness.dark
        ? AppColors.iconBoxDark
        : AppColors.iconBox,
    iconColor: scheme.brightness == Brightness.dark
        ? AppColors.iconBoxIconDark
        : AppColors.iconBoxIcon,
  );
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
