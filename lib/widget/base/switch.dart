import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/color.dart';
import 'package:once_power/constant/number.dart';

/// 紧凑开关。
///
/// 官方 Switch 在 Material 3 下轨道为 52×32，另带直径 40 的 hover 涟漪，
/// 放进 32 高的底栏会把整行撑满。这里自绘一个默认 28×16 的轨道：
/// 占位即轨道本身，hover 只微调轨道颜色，不画超出轨道的圆形反馈。
class const EasySwitch({
  super.key,
  required final bool value,
  required final ValueChanged<bool>? onChanged,
  final String? label,
  final double space = 0,
  final Widget? child,
  final double width = 36.0,
  final double height = 20.0,
  final double padding = 2.0,
  final Color? activeColor,
  final Color? inactiveColor,
  final Color? thumbColor,
  final Duration duration = const Duration(milliseconds: 150),
}) extends StatefulWidget {
  this
    : assert(height > padding * 2, 'height 必须大于两倍 padding'),
      assert(width >= height, 'width 不能小于 height');

  @override
  State<EasySwitch> createState() => _EasySwitchState();
}

class _EasySwitchState extends State<EasySwitch> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool dark = theme.brightness == Brightness.dark;
    final bool enabled = widget.onChanged != null;
    final double thumbSize = widget.height - widget.padding * 2;

    final Color active = widget.activeColor ?? theme.colorScheme.primary;
    final Color inactive =
        widget.inactiveColor ??
        (dark ? const Color(0xFF49454F) : const Color(0xFFD9D9D9));
    final Color outline = dark
        ? const Color(0xFF938F99)
        : const Color(0xFFBDBDBD);
    final Color thumb =
        widget.thumbColor ??
        (widget.value
            ? theme.colorScheme.onPrimary
            : (dark ? AppColors.darkSwitchThumb : AppColors.switchThumb));

    Color trackColor = widget.value ? active : inactive;
    if (enabled && _hovering) {
      trackColor = Color.lerp(
        trackColor,
        dark ? Colors.white : Colors.black,
        dark ? 0.10 : 0.06,
      )!;
    }

    final Widget track = AnimatedContainer(
      duration: widget.duration,
      curve: Curves.easeOutCubic,
      width: widget.width,
      height: widget.height,
      alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.all(widget.padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.height / 2),
        color: trackColor,
        border: Border.all(
          color: widget.value ? Colors.transparent : outline,
          width: 1,
        ),
      ),
      child: SizedBox.square(
        dimension: thumbSize,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: thumb,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );

    Widget control = MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: enabled ? (_) => setState(() => _hovering = true) : null,
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: enabled ? () => widget.onChanged!(!widget.value) : null,
        child: Semantics(
          toggled: widget.value,
          enabled: enabled,
          label: widget.label,
          child: track,
        ),
      ),
    );

    if (!enabled) {
      control = Opacity(opacity: 0.45, child: control);
    }

    // 外壳固定 widgetHeight；轨道、thumb 保持原尺寸并垂直居中，不随外壳撑高。
    final bool hasAccessory = widget.label != null || widget.child != null;
    final Widget content = !hasAccessory
        ? control
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              control,
              if (widget.label != null)
                Text(
                  widget.label!,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                ),
              if (widget.space > 0) SizedBox(width: widget.space),
              ?widget.child,
            ],
          );

    return RepaintBoundary(
      child: SizedBox(
        height: AppNumber.widgetHeight,
        child: Row(
          mainAxisSize: .min,
          crossAxisAlignment: .center,
          children: [content],
        ),
      ),
    );
  }
}
