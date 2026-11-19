import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/setting/card.dart';
import 'package:once_power/widget/setting/shortcut.dart';

class ShortcutView extends StatelessWidget {
  const ShortcutView({super.key});

  /// 每格最小宽度。列数 = floor(可用宽度 / 250)，不足两格时单格铺满。
  static const double _minTileWidth = 250;

  /// 列间距。算每格宽度时要先扣掉它，否则 Row 总宽会超出容器。
  static const double _spacing = 24.0;

  @override
  Widget build(BuildContext context) {
    final items = <({List<String> keys, String label})>[
      (keys: ['Ctrl', 'A'], label: context.tr(AppL10n.shortcutAll)),
      (keys: ['Ctrl', 'D'], label: context.tr(AppL10n.shortcutCancel)),
      (keys: ['Ctrl', 'S'], label: context.tr(AppL10n.shortcutToggle)),
      (keys: ['Ctrl', 'X'], label: context.tr(AppL10n.shortcutStash)),
      (keys: ['Ctrl', 'C'], label: context.tr(AppL10n.shortcutFront)),
      (keys: ['Ctrl', 'V'], label: context.tr(AppL10n.shortcutBehind)),
      (keys: ['Delete'], label: context.tr(AppL10n.shortcutDelete)),
    ];

    return SettingCard(
      title: context.tr(AppL10n.shortcut),
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double width = constraints.hasBoundedWidth
                ? constraints.maxWidth
                : _minTileWidth * 2;
            final int columns = math.max(1, (width / _minTileWidth).floor());
            final double tileWidth =
                (width - _spacing * (columns - 1)) / columns;

            return Column(
              spacing: AppNumber.spaceMedium,
              children: [
                for (int i = 0; i < items.length; i += columns)
                  Row(
                    spacing: _spacing,
                    children: [
                      for (int j = 0; j < columns && i + j < items.length; j++)
                        SizedBox(
                          width: tileWidth,
                          child: ShortcutContent(
                            keys: items[i + j].keys,
                            label: items[i + j].label,
                          ),
                        ),
                    ],
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
