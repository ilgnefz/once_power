import 'package:flutter_color_picker/flutter_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/color.dart';
import 'package:once_power/constant/key.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/app.dart';
import 'package:once_power/provider/switch.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/service/storage.dart';
import 'package:once_power/widget/setting/card.dart';
import 'package:once_power/widget/setting/color.dart';
import 'package:once_power/widget/setting/menu.dart';

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

class ThemeView extends ConsumerStatefulWidget {
  const ThemeView({super.key});

  @override
  ConsumerState<ThemeView> createState() => _ThemeViewState();
}

class _ThemeViewState extends ConsumerState<ThemeView> {
  @override
  Widget build(BuildContext context) {
    final int seed = ref.watch(themeColorProvider);
    final bool isCustomColor = !AppColors.themeSeeds.contains(seed);
    return SettingCard(
      title: context.tr(AppL10n.appearance),
      children: [
        SettingMenu<ThemeType>.dropdown(
          // width: 160.0,
          label: context.tr(AppL10n.theme),
          value: ref.watch(currentThemeProvider),
          items: ThemeType.values.map((value) {
            return TextDropdownItem<ThemeType>(value, label: value.label);
          }).toList(),
          onChanged: (value) =>
              ref.read(currentThemeProvider.notifier).update(value),
        ),
        SettingMenu(
          label: context.tr(AppL10n.color),
          action: Flexible(
            child: Wrap(
              spacing: AppNumber.spaceMedium,
              runSpacing: AppNumber.spaceMedium,
              alignment: .end,
              children: [
                ...AppColors.themeSeeds.map(
                  (int color) => ColorItem(
                    color: color,
                    isSelected: seed == color,
                    onTap: () async {
                      ref.read(themeColorProvider.notifier).update(color);
                      await StorageService.setInt(AppKeys.color, color);
                    },
                  ),
                ),
                Builder(
                  builder: (BuildContext buttonContext) {
                    return ColorItem(
                      colors: _pickerWheelColors,
                      isSelected: isCustomColor,
                      onTap: () {
                        showColorPicker(
                          buttonContext,
                          color: Color(seed),
                          hexFormat: ColorHexFormat.flutterArgb,
                          align: ColorPickerAlign.end,
                          onChangeEnd: (value) async {
                            ref.read(themeColorProvider.notifier).update(value);
                            await StorageService.setInt(AppKeys.color, value);
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
