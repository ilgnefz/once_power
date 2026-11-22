import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/text.dart';

import 'button.dart';

/// ColorFiltered 效果示例页。
///
/// 把同一个 [ColorFilter] 同时作用在「图片」与「组件 + 文字」上，
/// 方便直观对比每种滤镜的真实表现。第一组 `linearToSrgbGamma`
/// 正是 `dialog_item.dart` 的 `SelectedBox` 用来做「未选中变淡」的方案，
/// 放在这里可以直接看出它对图片与 UI 组件分别是什么效果。
class ReplaceDialog extends StatelessWidget {
  const ReplaceDialog({super.key});

  static const String _imagePath = r'D:\天翼云盘下载\AI\B6gwbZI.png';

  /// 标准灰度矩阵（亮度权重 0.2126 / 0.7152 / 0.0722）。
  static const List<double> _greyMatrix = [
    0.2126, 0.7152, 0.0722, 0, 0, //
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0,
  ];

  static const List<_FilterEntry> _filters = [
    _FilterEntry('原图 / 原样（无滤镜）', null),
    _FilterEntry(
      'linearToSrgbGamma（dialog_item 当前用法）',
      ColorFilter.linearToSrgbGamma(),
    ),
    _FilterEntry('srgbToLinearGamma', ColorFilter.srgbToLinearGamma()),
    _FilterEntry(
      '去饱和置灰 · saturation',
      ColorFilter.mode(Colors.grey, BlendMode.saturation),
    ),
    _FilterEntry(
      '半透明遮罩 · srcATop',
      ColorFilter.mode(Colors.black38, BlendMode.srcATop),
    ),
    _FilterEntry('灰度矩阵 · matrix', ColorFilter.matrix(_greyMatrix)),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double contentMax =
            (constraints.maxHeight -
                    AppNumber.widgetHeight -
                    AppNumber.spaceMedium)
                .clamp(0.0, double.infinity)
                .toDouble();
        return Column(
          spacing: AppNumber.spaceMedium,
          mainAxisSize: .min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: contentMax),
              child: SingleChildScrollView(
                padding: .symmetric(horizontal: AppNumber.padding),
                child: Column(
                  crossAxisAlignment: .stretch,
                  spacing: AppNumber.spaceMedium,
                  children: [
                    for (final entry in _filters)
                      _FilterSample(entry: entry, imagePath: _imagePath),
                  ],
                ),
              ),
            ),
            ButtonGroup(
              group: '0',
              onComplete: () {},
              onCompleteExit: () {},
              onGroupChange: (value) {},
            ),
          ],
        );
      },
    );
  }
}

class _FilterEntry {
  const _FilterEntry(this.label, this.filter);

  final String label;
  final ColorFilter? filter;
}

class _FilterSample extends StatelessWidget {
  const _FilterSample({required this.entry, required this.imagePath});

  final _FilterEntry entry;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    // 标题保持在滤镜之外，避免文字一起变色、影响阅读。
    final Widget content = Row(
      crossAxisAlignment: .start,
      spacing: AppNumber.padding,
      children: [
        SizedBox(
          width: AppNumber.gridCellWidth,
          child: AspectRatio(
            aspectRatio: 1152 / 1472,
            child: Image.file(
              File(imagePath),
              fit: .cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                alignment: .center,
                child: const Icon(Icons.broken_image_outlined),
              ),
            ),
          ),
        ),
        const Expanded(child: _WidgetSample()),
      ],
    );

    final filter = entry.filter;
    return Column(
      crossAxisAlignment: .stretch,
      spacing: AppNumber.paddingSmall,
      children: [
        BaseText(entry.label, fontWeight: FontWeight.bold),
        filter == null
            ? content
            : ColorFiltered(colorFilter: filter, child: content),
      ],
    );
  }
}

/// 组件 + 文字的示例内容：主题色 Chip、图标与两段文字，
/// 用来观察滤镜作用在 UI 组件（而非图片）上的表现。
class _WidgetSample extends StatelessWidget {
  const _WidgetSample();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: .start,
      spacing: AppNumber.paddingSmall,
      children: [
        BaseText('组件文字 Abc 123', fontSize: 16, fontWeight: FontWeight.bold),
        Row(
          mainAxisSize: .min,
          spacing: AppNumber.space,
          children: [
            Container(
              padding: .symmetric(
                horizontal: AppNumber.paddingMedium,
                vertical: AppNumber.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: .circular(AppNumber.radiusSmall),
              ),
              child: Row(
                mainAxisSize: .min,
                spacing: AppNumber.spaceSmall,
                children: [
                  Icon(Icons.check, size: 16, color: colorScheme.onPrimary),
                  BaseText('选中 Chip', color: colorScheme.onPrimary),
                ],
              ),
            ),
            Icon(Icons.star, size: AppNumber.widgetHeight, color: colorScheme.primary),
          ],
        ),
        const BaseText('默认文字 abc 123 — ColorFiltered'),
      ],
    );
  }
}
