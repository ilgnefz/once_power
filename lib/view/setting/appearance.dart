import 'package:flutter_color_picker/flutter_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/theme/theme.dart';
import 'package:once_power/constant/color.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/app.dart';
import 'package:once_power/model/appearance.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/setting/card.dart';
import 'package:once_power/widget/setting/color.dart';
import 'package:once_power/widget/setting/menu.dart';
import 'package:once_power/widget/setting/theme_card.dart';

const List<Color> _pickerWheelColors = [
  Color(0xFFFF4D4F),
  Color(0xFFFA8C16),
  Color(0xFFFADB14),
  Color(0xFFA0D911),
  Color(0xFF52C41A),
  Color(0xFF13C2C2),
  Color(0xFF1677FF),
  Color(0xFF2F54EB),
  Color(0xFF722ED1),
  Color(0xFFEB2F96),
  Color(0xFFFF4D4F),
];

class AppearanceView extends ConsumerStatefulWidget {
  const AppearanceView({super.key});

  @override
  ConsumerState<AppearanceView> createState() => _ThemeViewState();
}

class _ThemeViewState extends ConsumerState<AppearanceView> {
  @override
  Widget build(BuildContext context) {
    final AppearanceSettings appearance = ref.watch(appearanceProvider);
    // 色块要预览「真正生效的 primary」，不能只画种子色：深色下种子跟表面
    // 对比度不够时 ThemeConfig 会回落到 fromSeed 的 tone 80。
    final Color lightPrimary = _primaryFor(appearance, Brightness.light);
    final Color darkPrimary = _primaryFor(appearance, Brightness.dark);
    return SettingCard(
      title: context.tr(AppL10n.appearance),
      children: [
        GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: AppNumber.spaceMedium,
            childAspectRatio: 3 / 2,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: ThemeType.values.map((e) {
            final bool selected = appearance.theme == e;
            final double width = selected ? 2.0 : 1.0;
            if (e.isSystem) {
              return SystemThemeCard(
                lightBorder: selected ? lightPrimary : AppColors.outline,
                darkBorder: selected ? darkPrimary : AppColors.darkOutline,
                borderWidth: width,
                lightPrimary: lightPrimary,
                darkPrimary: darkPrimary,
                lightBackground: appearance.lightBackgroundColor,
                darkBackground: appearance.darkBackgroundColor,
              );
            }
            return ThemeCard(
              type: e,
              border: selected
                  ? Theme.of(context).colorScheme.primary
                  : e.isDark
                  ? AppColors.darkOutline
                  : AppColors.outline,
              borderWidth: width,
              lightPrimary: lightPrimary,
              darkPrimary: darkPrimary,
              lightBackground: appearance.lightBackgroundColor,
              darkBackground: appearance.darkBackgroundColor,
            );
          }).toList(),
        ),
        // SizedBox(height: AppNumber.spaceSmall / 2),
        BaseText(
          context.tr(AppL10n.light),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        _ThemeColorMenu(
          label: context.tr(AppL10n.color),
          seed: appearance.lightSeed,
          brightness: Brightness.light,
          appearance: appearance,
          onChanged: ref.read(lightThemeColorProvider.notifier).update,
        ),
        _ThemeColorMenu(
          label: context.tr(AppL10n.background),
          seed: appearance.lightBackground,
          seeds: AppColors.backgroundSeeds,
          isBackground: true,
          brightness: Brightness.light,
          appearance: appearance,
          onChanged: ref.read(lightBackgroundColorProvider.notifier).update,
        ),
        _ThemeColorMenu(
          label: context.tr(AppL10n.controlSurface),
          seed: appearance.lightComponentSurface,
          seeds: [AppColors.controlSurface.toARGB32()],
          isBackground: true,
          brightness: Brightness.light,
          appearance: appearance,
          onChanged: ref
              .read(lightComponentSurfaceColorProvider.notifier)
              .update,
        ),
        _ThemeColorMenu(
          label: context.tr(AppL10n.containerSurface),
          seed: appearance.lightContainerSurface,
          seeds: [AppColors.containerSurface.toARGB32()],
          isBackground: true,
          brightness: Brightness.light,
          appearance: appearance,
          onChanged: ref
              .read(lightContainerSurfaceColorProvider.notifier)
              .update,
        ),
        _ThemeColorMenu(
          label: context.tr(AppL10n.icon),
          seed: appearance.lightIcon,
          seeds: [AppColors.icon.toARGB32()],
          isBackground: true,
          brightness: Brightness.light,
          appearance: appearance,
          onChanged: ref.read(lightIconColorProvider.notifier).update,
        ),
        _ThemeColorMenu(
          label: context.tr(AppL10n.outline),
          seed: appearance.lightOutline,
          seeds: [AppColors.outline.toARGB32()],
          isBackground: true,
          brightness: Brightness.light,
          appearance: appearance,
          onChanged: ref.read(lightOutlineColorProvider.notifier).update,
        ),
        SettingMenu.toggle(
          label: context.tr(AppL10n.sync),
          value: appearance.lightSync,
          onChanged: (_) => ref.read(isLightSyncProvider.notifier).toggle(),
        ),
        SettingMenu.toggle(
          label: context.tr(AppL10n.divider),
          value: appearance.lightTransparent,
          onChanged: (_) =>
              ref.read(isLightTransparentProvider.notifier).toggle(),
        ),
        BaseText(
          context.tr(AppL10n.dark),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        _ThemeColorMenu(
          label: context.tr(AppL10n.color),
          seed: appearance.darkSeed,
          brightness: Brightness.dark,
          appearance: appearance,
          onChanged: ref.read(darkThemeColorProvider.notifier).update,
        ),
        _ThemeColorMenu(
          label: context.tr(AppL10n.background),
          seed: appearance.darkBackground,
          seeds: AppColors.darkBackgroundSeeds,
          isBackground: true,
          brightness: Brightness.dark,
          appearance: appearance,
          onChanged: ref.read(darkBackgroundColorProvider.notifier).update,
        ),
        _ThemeColorMenu(
          label: context.tr(AppL10n.controlSurface),
          seed: appearance.darkComponentSurface,
          seeds: [AppColors.darkControlSurface.toARGB32()],
          isBackground: true,
          brightness: Brightness.dark,
          appearance: appearance,
          onChanged: ref
              .read(darkComponentSurfaceColorProvider.notifier)
              .update,
        ),
        _ThemeColorMenu(
          label: context.tr(AppL10n.containerSurface),
          seed: appearance.darkContainerSurface,
          seeds: [AppColors.darkContainerSurface.toARGB32()],
          isBackground: true,
          brightness: Brightness.dark,
          appearance: appearance,
          onChanged: ref
              .read(darkContainerSurfaceColorProvider.notifier)
              .update,
        ),
        _ThemeColorMenu(
          label: context.tr(AppL10n.icon),
          seed: appearance.darkIcon,
          seeds: [AppColors.darkIcon.toARGB32()],
          isBackground: true,
          brightness: Brightness.dark,
          appearance: appearance,
          onChanged: ref.read(darkIconColorProvider.notifier).update,
        ),
        _ThemeColorMenu(
          label: context.tr(AppL10n.outline),
          seed: appearance.darkOutline,
          seeds: [AppColors.darkOutline.toARGB32()],
          isBackground: true,
          brightness: Brightness.dark,
          appearance: appearance,
          onChanged: ref.read(darkOutlineColorProvider.notifier).update,
        ),
        SettingMenu.toggle(
          label: context.tr(AppL10n.sync),
          value: appearance.darkSync,
          onChanged: (_) => ref.read(isDarkSyncProvider.notifier).toggle(),
        ),
        SettingMenu.toggle(
          label: context.tr(AppL10n.divider),
          value: appearance.darkTransparent,
          onChanged: (_) =>
              ref.read(isDarkTransparentProvider.notifier).toggle(),
        ),
      ],
    );
  }

  /// 给定明暗下实际生效的 primary（种子对比度不足时会回落到派生 tone）。
  static Color _primaryFor(
    AppearanceSettings appearance,
    Brightness brightness,
  ) => ThemeConfig.colorScheme(
    appearance.seedFor(brightness),
    brightness,
    background: appearance.backgroundFor(brightness),
    componentSurface: appearance.componentSurfaceFor(brightness),
    containerSurface: appearance.containerSurfaceFor(brightness),
    icon: appearance.iconFor(brightness),
    outline: appearance.outlineFor(brightness),
    syncBackground: appearance.syncFor(brightness),
  ).scheme.primary;
}

/// 一行颜色：预设色块 + 自定义取色。
///
/// [seed] 是当前模式下已存的值，[onChanged] 负责写回对应 provider
/// （provider 内部已经做了持久化，这里不用再动 Storage）。
/// 主题色行画的是派生后的 primary，其余行直接画颜色本身。
class _ThemeColorMenu extends StatelessWidget {
  const _ThemeColorMenu({
    required this.label,
    required this.seed,
    required this.brightness,
    required this.appearance,
    required this.onChanged,
    this.seeds = AppColors.themeSeeds,
    this.isBackground = false,
  });

  final String label;
  final int seed;
  final Brightness brightness;
  final ValueChanged<int> onChanged;
  final List<int> seeds;
  final bool isBackground;

  /// 主题色预览按当前设置实际生效的颜色计算，故需要整份快照。
  final AppearanceSettings appearance;

  /// 不是预设色就说明是自定义色，取色按钮要显示为选中。
  bool get _isCustom => !seeds.contains(seed);

  @override
  Widget build(BuildContext context) {
    return SettingMenu(
      label: label,
      action: Flexible(
        child: Wrap(
          spacing: AppNumber.spaceMedium,
          runSpacing: AppNumber.spaceMedium,
          alignment: WrapAlignment.end,
          children: [
            ...seeds.map(
              (int color) => ColorItem(
                // 主题色画实际生效的 primary；其他颜色画颜色本身。
                color: isBackground
                    ? color
                    : ThemeConfig.colorScheme(
                        Color(color),
                        brightness,
                        background: appearance.backgroundFor(brightness),
                        componentSurface: appearance.componentSurfaceFor(
                          brightness,
                        ),
                        containerSurface: appearance.containerSurfaceFor(
                          brightness,
                        ),
                        icon: appearance.iconFor(brightness),
                        outline: appearance.outlineFor(brightness),
                        syncBackground: appearance.syncFor(brightness),
                      ).scheme.primary.toARGB32(),
                isSelected: seed == color,
                onTap: () => onChanged(color),
              ),
            ),
            Builder(
              builder: (buttonContext) => ColorItem(
                colors: _pickerWheelColors,
                isSelected: _isCustom,
                onTap: () {
                  showColorPicker(
                    buttonContext,
                    color: Color(seed),
                    hexFormat: ColorHexFormat.flutterArgb,
                    align: ColorPickerAlign.end,
                    onChangeEnd: onChanged,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
