import 'dart:ui';

/// 颜色表
///
/// 浅色模式：中性灰 + primary tonal 90（button #F3E8F4）
/// 深色模式：Material 3 tonal 深色 —— 表面带极低饱和度的紫，与浅色的紫调呼应。
/// 深色表面按 elevation 分四级，越高越亮：
///   background   #1C1B1F  (surface)
///   input/table  #211F26  (surfaceContainer)
///   对话框      #2B2930  (surfaceContainerHigh)
///   chip/选中    #36343B  (easyChip / iconBox 自有色，不走 ColorScheme)
/// 前景：主文字 #E6E1E5，次级文字/图标 #CAC4D0，弱化文字 #938F99
class AppColors {
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

  /// 背景色预设：第一个是默认值。背景色在色块里画的就是它自己，不做 tonal 派生。
  static const List<int> backgroundSeeds = <int>[
    0xFFFFFFFF,
    0xFFFAFAFA,
    0xFFF5F5F5,
    0xFFEEF0F2,
    0xFFFFF8E1,
    0xFFECEFF4,
  ];
  static const List<int> darkBackgroundSeeds = <int>[
    0xFF1C1B1F,
    0xFF000000,
    0xFF121212,
    0xFF211F26,
    0xFF1B2027,
    0xFF26211F,
  ];

  // Dialog：Material Dialog 默认背景（surfaceContainerHigh）
  static const Color dialog = Color(0xFFFFFFFF);
  static const Color darkDialog = Color(0xFF2B2930);

  // Divider
  static const Color divider = Color(0xFFF5F5F5);
  static const Color darkDivider = Color(0xFF49454F);

  // 容器底色：NumberInput / EasyChip / IconBox 共用的表面色，也是三者的默认值。
  // 与控件底色的默认白不同，这一层默认带一点灰，用来和页面背景/输入框拉开层次。
  static const Color containerSurface = Color(0xFFF1F1F1);
  static const Color darkContainerSurface = Color(0xFF36343B);

  // EasyChip
  static const Color easyChipText = Color(0xFFA8A8A8);
  static const Color darkEasyChipText = Color(0xFFCAC4D0);

  // Icon
  static const Color icon = Color(0xFFA8A8A8);
  static const Color darkIcon = Color(0xFFA8A8A8);
  static const Color titleBar = Color(0xFF9E9E9E);
  static const Color titleBarDark = Color(0xFF938F99);

  // Switch
  static const Color switchThumb = Color(0xFFFFFFFF);
  static const Color darkSwitchThumb = Color(0xFFCAC4D0);

  // IconBox
  static const Color iconBox = Color(0xFFF1F1F1);
  static const Color darkIconBox = Color(0xFF36343B);

  // controlSurface
  static const Color controlSurface = Color(0xFFFFFFFF);
  static const Color darkControlSurface = Color(0xFF211F26);

  // outline
  static const Color outline = Color(0xFFF1F1F1);
  static const Color darkOutline = Color(0xFF49454F);

  // Text
  static const Color text = Color(0xFF1D1D1F);
  static const Color darkText = Color(0xFFF5F5F7);
  static const Color textHint = Color(0xFFA8A8A8);
  static const Color darkTextHint = Color(0xFF938F99);
}
