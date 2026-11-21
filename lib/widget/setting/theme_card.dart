import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/color.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/app.dart';
import 'package:once_power/provider/switch.dart';

/// 主题选择卡：一张卡只负责一种模式，浅色卡和深色卡用同一个组件、只有配色不同。
///
/// 「跟随系统」由 [SystemThemeCard] 把真正的浅色卡左半边和深色卡右半边拼起来。
class const ThemeCard({
  super.key,
  required final ThemeType type,
  required final Color border,
  required final double borderWidth,
  required final Color lightPrimary,
  required final Color darkPrimary,
  required final Color lightBackground,
  required final Color darkBackground,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _CardFace(
      type: type,
      border: border,
      borderWidth: borderWidth,
      lightPrimary: lightPrimary,
      darkPrimary: darkPrimary,
      lightBackground: lightBackground,
      darkBackground: darkBackground,
      onTap: () => ref.read(currentThemeProvider.notifier).update(type),
    );
  }
}

/// 跟随系统：浅色 ThemeCard 的左半边 + 深色 ThemeCard 的右半边。
///
/// 两半的边框各传各的：[lightBorder] 走浅色描边，[darkBorder] 走深色描边，
/// 拼起来后整张卡的上/下、左/右边框自然分成深浅两色。
class const SystemThemeCard({
  super.key,
  required final Color lightBorder,
  required final Color darkBorder,
  required final double borderWidth,
  required final Color lightPrimary,
  required final Color darkPrimary,
  required final Color lightBackground,
  required final Color darkBackground,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void select() =>
        ref.read(currentThemeProvider.notifier).update(ThemeType.system);

    Widget half({
      required ThemeType type,
      required Color border,
      required bool showLeft,
    }) {
      // 每半必须各自包一层透明 Material：Ink 的背景画在最近的祖先 Material
      // 墨层上，不包的话两半的背景都会画满整张卡，ClipRect 裁不到。
      return ClipRect(
        clipper: _HalfClipper(showLeft: showLeft),
        child: Material(
          type: MaterialType.transparency,
          child: _CardFace(
            type: type,
            border: border,
            borderWidth: borderWidth,
            lightPrimary: lightPrimary,
            darkPrimary: darkPrimary,
            lightBackground: lightBackground,
            darkBackground: darkBackground,
          ),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        half(type: ThemeType.dark, border: darkBorder, showLeft: false),
        half(type: ThemeType.light, border: lightBorder, showLeft: true),
        // 共享涟漪放最上层：Ink 的墨层画在 Material 子控件下面，若把
        // InkWell 放最外层会被两半不透明的卡面盖住，水波纹就看不见。
        Positioned.fill(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              mouseCursor: SystemMouseCursors.click,
              borderRadius: .circular(AppNumber.radius),
              onTap: select,
              child: const SizedBox.expand(),
            ),
          ),
        ),
      ],
    );
  }
}

/// 一张卡的全部视觉：卡面 + 底部那个「小窗口」预览。浅色卡和深色卡共用。
class _CardFace extends StatelessWidget {
  const _CardFace({
    required this.type,
    required this.border,
    required this.borderWidth,
    required this.lightPrimary,
    required this.darkPrimary,
    required this.lightBackground,
    required this.darkBackground,
    this.onTap,
  });

  final ThemeType type;
  final Color border;
  final double borderWidth;
  final Color lightPrimary;
  final Color darkPrimary;
  final Color lightBackground;
  final Color darkBackground;

  /// 为空时不加 InkWell：SystemThemeCard 在整张卡外面放一个共享的涟漪。
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool dark = type.isDark;
    final Color surface = dark ? darkBackground : lightBackground;
    final Color outline = dark ? AppColors.darkOutline : AppColors.outline;
    final Color accent = dark ? darkPrimary : lightPrimary;

    final Widget content = Align(
      alignment: .bottomCenter,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double width = constraints.maxWidth * .7;
          final BorderRadiusGeometry blockRadius = .vertical(
            top: .circular(AppNumber.radiusSmall),
          );
          return Container(
            padding: .only(
              top: AppNumber.paddingMedium,
              left: AppNumber.paddingMedium,
              right: AppNumber.paddingMedium,
            ),
            width: width,
            height: width * 3 / 4,
            decoration: BoxDecoration(
              color: surface,
              borderRadius: .vertical(top: .circular(AppNumber.radius)),
              border: Border(
                top: BorderSide(color: outline, width: 1),
                left: BorderSide(color: outline, width: 1),
                right: BorderSide(color: outline, width: 1),
              ),
            ),
            child: Row(
              spacing: AppNumber.spaceSmall,
              children: [
                Container(
                  width: width * .25,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: blockRadius,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: blockRadius,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return Ink(
      decoration: BoxDecoration(
        color: type.isDark ? Colors.black : Colors.white,
        borderRadius: .circular(AppNumber.radius),
        border: Border.all(color: border, width: borderWidth),
      ),
      child: onTap == null
          ? content
          : InkWell(
              mouseCursor: SystemMouseCursors.click,
              borderRadius: .circular(AppNumber.radius),
              onTap: onTap,
              child: content,
            ),
    );
  }
}

/// 上层卡片只露一半：[showLeft] 为真露左半边，否则露右半边。
class _HalfClipper extends CustomClipper<Rect> {
  const _HalfClipper({required this.showLeft});

  final bool showLeft;

  @override
  Rect getClip(Size size) => showLeft
      ? Rect.fromLTWH(0, 0, size.width / 2, size.height)
      : Rect.fromLTWH(size.width / 2, 0, size.width / 2, size.height);

  @override
  bool shouldReclip(_HalfClipper oldClipper) => oldClipper.showLeft != showLeft;
}
