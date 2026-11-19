import 'dart:ui';

/// 颜色表
///
/// 浅色模式：中性灰 + primary tonal 90（button #F3E8F4）
/// 深色模式：Material 3 tonal 深色 —— 表面带极低饱和度的紫，与浅色的紫调呼应。
/// 深色表面按 elevation 分四级，越高越亮：
///   background   #1C1B1F  (surface)
///   input/table  #211F26  (surfaceContainer)
///   浮层/弹窗    #2B2930  (surfaceContainerHigh)
///   chip/选中    #36343B  (surfaceContainerHighest)
/// 前景：主文字 #E6E1E5，次级文字/图标 #CAC4D0，弱化文字 #938F99
class AppColors {
  static const Color primary = Color(0xFF6750A4);
  static const Color primaryDark = Color(0xFFD0BCFF); // tonal 80，只做前景（文字/图标）

  /// 设置页可选的强调色种子（ARGB 整数：存储、ColorItem 都直接用这份）。
  ///
  /// 第一个是默认值，就是 Material 3 基线紫 #6750A4 —— 整套主题色由它派生出
  /// 明暗两套 `ColorScheme`（见 `ThemeConfig.colorScheme`），除了这里和
  /// `DropdownStyle.dark()` 之类需要硬编码表面色的地方，界面里不该再出现
  /// 强调色的字面量。
  static const List<int> themeSeeds = <int>[
    0xFF6750A4,
    0xFFA45050,
    0xFFA47A50,
    0xFFA4A450,
    0xFF50A450,
    0xFF5050A4,
  ];

  static const Color onPrimaryDark = Color(
    0xFF381E72,
  ); // tonal 20，primaryDark 背景上的文字
  static const Color primaryContainerDark = Color(
    0xFF4F378B,
  ); // tonal 30，深色下的选中态背景
  static const Color onPrimaryContainerDark = Color(
    0xFFEADDFF,
  ); // tonal 90，其上的文字
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF1C1B1F);

  //  Button
  static const Color button = Color(0xFFF3E8F4);
  static const Color buttonDark = Color(0xFF4A4458);

  // Tooltip 气泡背景（独立于主题色，中性灰，不跟随 primary 的紫调）
  // 浅色：纯白，靠阴影与页面区分
  // 深色：中性深灰，与页面表面拉开层次又不抢内容
  static const Color tooltip = Color(0xFFFFFFFF);
  static const Color tooltipDark = Color(0xFF3A3A3A);
  static const Color tooltipText = Color(0xFF2B2B2B);
  static const Color tooltipTextDark = Color(0xFFF2F2F2);

  // OverlayWidget
  static const Color overlayWidget = Color(0xFFFFFFFF);
  static const Color overlayWidgetDark = Color(0xFF2B2930);

  // Divider
  static const Color divider = Color(0xFFF5F5F5);
  static const Color dividerDark = Color(0xFF49454F);

  // Dropdown
  static const Color dropdown = Color(0xFFF1F1F1);
  static const Color dropdownDark = Color(0xFF36343B);
  static const Color dropdownBackground = Color(0xFFFFFFFF);
  static const Color dropdownBackgroundDark = Color(0xFF211F26);

  // EasyChip
  static const Color easyChip = Color(0xFFF1F1F1);
  static const Color easyChipDark = Color(0xFF36343B);
  static const Color easyChipText = Color(0xFFA8A8A8);
  static const Color easyChipTextDark = Color(0xFFCAC4D0);

  // Icon
  static const Color icon = Color(0xFFA8A8A8);
  static const Color iconDark = Color(0xFFCAC4D0);
  static const Color titleBar = Color(0xFF9E9E9E);
  static const Color titleBarDark = Color(0xFF938F99);

  // IconBox
  static const Color iconBox = Color(0xFFF1F1F1);
  static const Color iconBoxDark = Color(0xFF36343B);
  static const Color iconBoxIcon = Color(0xFFA8A8A8);
  static const Color iconBoxIconDark = Color(0xFFCAC4D0);

  // Input
  static const Color input = Color(0xFFFFFFFF);
  static const Color inputDark = Color(0xFF211F26);
  static const Color inputBorder = Color(0xFFF1F1F1);
  static const Color inputBorderDark = Color(0xFF49454F);
  static const Color inputHint = Color(0xFF999999);
  static const Color inputHintDark = Color(0xFF938F99);

  // Table
  static const Color table = Color(0xFFF5F5F5);
  static const Color tableDark = Color(0xFF211F26);

  // Text
  static const Color text = Color(0xFF000000);
  static const Color textDark = Color(0xFFE6E1E5);
  static const Color textHint = Color(0xFFA8A8A8);
  static const Color textHintDark = Color(0xFF938F99);
  static const Color bottomText = Color(0xFF9E9E9E);
  static const Color bottomTextDark = Color(0xFF938F99);

  // List
  static const Color selected = Color(0xFFE0E0E0);
  static const Color selectedDark = Color(0xFF36343B);
}
