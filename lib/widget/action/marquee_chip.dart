import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/theme/chip.dart';
import 'package:once_power/constant/number.dart';

/// 一行「内容自适应、共同占满父宽度」的**可多选** chip。
///
/// 泛型 [T] 是数据本身（通常是枚举），不是标签文字：[onTap] 直接把点中的那项
/// 原样交回，外部拿它去做 `set.contains(item)` / `notifier.update(item)`，
/// 不必再绕一层下标。
///
/// 父组件给出固定宽高后：
///
/// * 每个 chip 的理想宽度 = 文字宽度 + 左右 [MarqueeChip.padding]；
/// * 理想宽度总和**不够**父宽度 → 按比例放大到铺满，长标签仍相对更宽；
/// * 理想宽度总和**超过**父宽度 → 按「超出部分」等比压缩，短文字优先保住完整
///   显示，长文字先被截断；[minWidth] 只是长标签的下限，本来就比它短的标签
///   保留自己的理想宽度，不会被强行拉宽；
/// * chip 之间隔 [spacing]，高度统一为 [height]。
///
/// 被截断的文字由 [MarqueeChip] 处理：静止时从头显示，鼠标悬停后无缝循环向左滚动。
///
/// 四种颜色（未选中/选中的文字与背景）都可单独覆盖，不传则走主题
/// [EasyChipTheme]；颜色会叠加到 [textStyle] 之上。
///
/// ```dart
/// MarqueeChipRow<ReplaceType>(
///   items: ReplaceType.values,
///   labelOf: (e) => e.label,
///   selected: ref.watch(selectedReplaceTypeProvider), // Set<ReplaceType>
///   onTap: (e) => ref.read(selectedReplaceTypeProvider.notifier).toggle(e),
///   color: Colors.grey,                 // 未选中文字
///   selectedTextColor: Colors.white,    // 选中文字
///   backgroundColor: Color(0xFFF1F1F1), // 未选中背景
///   selectedBackgroundColor: Colors.blue,
/// )
/// ```
class MarqueeChipRow<T extends Object> extends StatelessWidget {
  const MarqueeChipRow({
    super.key,
    required this.items,
    this.labelOf,
    this.selected,
    this.spacing = AppNumber.spaceMedium,
    this.height = AppNumber.widgetHeight,
    this.minWidth = 48,
    this.textStyle,
    this.color,
    this.selectedTextColor,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.onTap,
    this.speed = 24,
    this.gap = 24,
  });

  /// 全部可选项；顺序即排列顺序。
  final List<T> items;

  /// 把一项转成 chip 上显示的文字。为 null 时取 `toString()`，枚举建议显式传 `.label`。
  final String Function(T)? labelOf;

  /// 当前选中的项（多选）。为 null 表示全不选中。判定用 `Set.contains`，
  /// 所以 [T] 需有正常的 `==`（枚举 / String 天然满足）。
  final Set<T>? selected;

  /// chip 之间的间距（主轴方向）。
  final double spacing;

  /// 整行高度。
  final double height;

  /// 空间不够时长标签的最小宽度；理想宽度本就小于它的标签不会被拉宽。
  final double minWidth;

  /// 文字样式；为 null 时取 EasyChipTheme.textStyle / ThemeData.bodyMedium。
  final TextStyle? textStyle;

  /// 未选中文字色；为 null 取主题。会覆盖 [textStyle] 里的 color。
  final Color? color;

  /// 选中文字色；为 null 取主题。
  final Color? selectedTextColor;

  /// 未选中背景色；为 null 取主题。
  final Color? backgroundColor;

  /// 选中背景色；为 null 取主题。
  final Color? selectedBackgroundColor;

  /// 点击某个 chip，参数就是被点的那一项 [T]；选中态由外部通过 [selected] 回传。
  final ValueChanged<T>? onTap;

  /// 跑马灯速度（逻辑像素 / 秒），默认 24，慢到能读清整段文字。
  final double speed;

  /// 循环串里相邻两段文字之间的间隔。
  final double gap;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int count = items.length;
        final double total = constraints.hasBoundedWidth ? constraints.maxWidth : 0;
        final double available = total - spacing * (count - 1);

        String label(int i) => labelOf?.call(items[i]) ?? items[i].toString();
        bool isSelected(int i) => selected?.contains(items[i]) ?? false;

        // 按各 chip 自己最终的样式测量（选中态可能是另一套字重/字号），
        // 否则被选中那颗会按未选中宽度分配、实际却更宽而误触发滚动。
        final List<double> desired = <double>[
          for (int i = 0; i < count; i++)
            _measureLabel(
                  context,
                  label(i),
                  _chipTextStyle(
                    context,
                    textStyle,
                    isSelected(i),
                    color: isSelected(i) ? selectedTextColor : color,
                  ),
                ) +
                AppNumber.padding * 2,
        ];
        final List<double> widths = _allocateWidths(
          available,
          desired,
          minWidth,
        );

        return Row(
          spacing: spacing,
          children: <Widget>[
            for (int i = 0; i < count; i++)
              SizedBox(
                width: widths[i],
                height: height,
                child: MarqueeChip(
                  label: label(i),
                  textStyle: textStyle,
                  selected: isSelected(i),
                  color: color,
                  selectedTextColor: selectedTextColor,
                  backgroundColor: backgroundColor,
                  selectedBackgroundColor: selectedBackgroundColor,
                  onTap: onTap == null ? null : () => onTap!(items[i]),
                  speed: speed,
                  gap: gap,
                ),
              ),
          ],
        );
      },
    );
  }
}

/// 文字放不下时会自动跑马灯的 chip。
///
/// 自己**不规定宽度**：由父级（通常是 [MarqueeChipRow] 或 `SizedBox` / `Expanded`）
/// 给一个定宽。拿到定宽后：
///
/// * 文字比可用宽度短 → 静止显示（居中），和 [EasyChip] 的观感一致；
/// * 文字超宽 → 静止显示前面那一段；鼠标移入后文字**无缝循环向左滚动**——
///   把 label 复制多段首尾相接，整体匀速左移，滚过一段（文字宽 + [gap]）后
///   画面恰好回到起点，于是跳回第 0 帧没有接缝。例如「你好世界」滚动中会
///   呈现「世界 … 你好」，移出立刻归位到开头。
class MarqueeChip extends StatefulWidget {
  const MarqueeChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.height = AppNumber.widgetHeight,
    this.padding = AppNumber.padding,
    this.textStyle,
    this.color,
    this.selectedTextColor,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.speed = 24,
    this.gap = 24,
  });

  /// 要显示的文字。
  final String label;

  /// 是否选中（切换背景与文字颜色，具体取哪组见下方颜色参数）。
  final bool selected;

  /// 点击回调；为 null 时光标保持普通箭头。
  final VoidCallback? onTap;

  /// chip 高度。
  final double height;

  /// 文字左右的留白。
  final double padding;

  /// 文字样式；为 null 时按选中态取 EasyChipTheme / ThemeData.bodyMedium。
  final TextStyle? textStyle;

  /// 未选中文字色。为 null 取主题的 EasyChipTheme.textStyle.color。
  final Color? color;

  /// 选中文字色。为 null 取主题的 EasyChipTheme.selectTextStyle.color。
  final Color? selectedTextColor;

  /// 未选中背景色。为 null 取主题的 EasyChipTheme.backgroundColor。
  final Color? backgroundColor;

  /// 选中背景色。为 null 取主题的 EasyChipTheme.selectBackgroundColor。
  final Color? selectedBackgroundColor;

  /// 跑马灯速度（逻辑像素 / 秒），默认 24，慢到能读清整段文字。
  final double speed;

  /// 循环串里相邻两段之间的间隔，也决定「你好世界」变成「世界 … 你好」时的空白。
  final double gap;

  @override
  State<MarqueeChip> createState() => _MarqueeChipState();
}

class _MarqueeChipState extends State<MarqueeChip>
    with SingleTickerProviderStateMixin {
  /// 0 → 1 表示整体向左平移「一段」的距离；到 1 时画面与 0 完全相同，
  /// repeat() 跳回 0 因此没有接缝。
  late final AnimationController _controller = AnimationController(vsync: this);

  /// 文字宽度 - 可用宽度；<= 0 表示放得下、不需要滚动。
  double _overflow = 0;

  /// 一个循环单元宽度 = 文字宽 + 段间 [gap]，也是每轮平移的总距离。
  double _unit = 0;

  /// 匀速滚过一段所需时长：unit / speed。
  ///
  /// 按「整段宽度」而不是「超出多少」计时——否则只超几个像素时一轮会快到
  /// 看不清；按整段算无论超多少，滚动速度恒为 [speed] px/s。
  void _syncDuration() {
    if (_unit <= 0) return;
    final int ms = (_unit / math.max(widget.speed, 1) * 1000).round();
    final Duration next = Duration(milliseconds: math.max(ms, 100));
    if (_controller.duration != next) _controller.duration = next;
  }

  void _onEnter() {
    if (_overflow <= 0 || _controller.isAnimating) return;
    _syncDuration();
    _controller.repeat();
  }

  void _onExit() {
    if (_controller.isAnimating) _controller.stop();
    // 归位到开头，下一次悬停重新从第一个字开始。
    _controller.value = 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final EasyChipTheme? chipTheme = theme.extension<EasyChipTheme>();
    final BorderRadius radius = BorderRadius.all(
      Radius.circular(AppNumber.radius),
    );
    final Color? background = widget.selected
        ? widget.selectedBackgroundColor ?? chipTheme?.selectBackgroundColor
        : widget.backgroundColor ?? chipTheme?.backgroundColor;
    final TextStyle style = _chipTextStyle(
      context,
      widget.textStyle,
      widget.selected,
      color: widget.selected ? widget.selectedTextColor : widget.color,
    );

    return MouseRegion(
      onEnter: (_) => _onEnter(),
      onExit: (_) => _onExit(),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool bounded = constraints.hasBoundedWidth;
          final double width = bounded ? constraints.maxWidth : 0;
          final double inner = bounded
              ? math.max(0.0, width - widget.padding * 2)
              : double.infinity;
          final double textWidth = _measureLabel(context, widget.label, style);
          final double raw = textWidth - inner;
          // 留 2px 容差：TextPainter 的 advance width 含字距留白，略有超出时
          // 文字其实完整可见，不值得启动一整段滚动。
          _overflow = bounded && raw > 2 ? raw : 0;
          _unit = textWidth + widget.gap;
          _syncDuration();

          final Widget text = Text(
            widget.label,
            style: style,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.clip,
          );

          // 没给定宽就保持普通 chip 行为，不裁切也不滚动。
          Widget content = text;
          if (bounded && _overflow > 0 && inner.isFinite) {
            // 复制若干段首尾相接：至少铺满视口再多一段，保证滚满一轮的
            // 过程中右边始终有内容补进来，不会露出空白。
            final int copies = math.max(2, (inner / _unit).ceil() + 1);
            final List<Widget> segments = <Widget>[
              for (int i = 0; i < copies; i++) ...<Widget>[
                text,
                SizedBox(width: widget.gap),
              ],
            ];
            content = ClipRect(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return Transform.translate(
                    // 整体向左平移；移动满 _unit 时画面与起点相同，
                    // repeat() 归零无接缝。
                    offset: Offset(-_unit * _controller.value, 0),
                    child: child,
                  );
                },
                // Row(mainAxisSize.min) 按内容宽度排布；OverflowBox 放开父级
                // 的紧宽度约束，否则超出的段会被 RenderParagraph 直接裁掉。
                child: OverflowBox(
                  alignment: Alignment.centerLeft,
                  maxWidth: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: segments,
                  ),
                ),
              ),
            );
          } else if (bounded) {
            // 放得下：静止居中显示。
            content = Align(alignment: Alignment.center, child: text);
          }

          return Material(
            borderRadius: radius,
            elevation: 0,
            color: background,
            child: Ink(
              decoration: BoxDecoration(color: background, borderRadius: radius),
              child: InkWell(
                onTap: widget.onTap,
                mouseCursor: widget.onTap == null
                    ? SystemMouseCursors.basic
                    : SystemMouseCursors.click,
                borderRadius: radius,
                child: SizedBox(
                  width: bounded ? width : null,
                  height: widget.height,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: widget.padding),
                    child: content,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// 和 Text 用同一套条件量宽度，避免「量出来放得下、实际却截断」。
double _measureLabel(BuildContext context, String label, TextStyle style) {
  final TextPainter painter = TextPainter(
    text: TextSpan(text: label, style: style),
    maxLines: 1,
    textDirection: Directionality.of(context),
    textScaler: MediaQuery.textScalerOf(context),
  )..layout();
  return painter.width;
}

/// 取 chip 的文字样式。优先级：显式 [color] > 本次传入的 [override] >
/// 主题对应选中态的 textStyle > bodyMedium。
TextStyle _chipTextStyle(
  BuildContext context,
  TextStyle? override,
  bool selected, {
  Color? color,
}) {
  final EasyChipTheme? chipTheme =
      Theme.of(context).extension<EasyChipTheme>();
  final TextStyle base = override ??
      (selected ? chipTheme?.selectTextStyle : chipTheme?.textStyle) ??
      Theme.of(context).textTheme.bodyMedium ??
      const TextStyle();
  return color == null ? base : base.copyWith(color: color);
}

/// 把各 chip 的理想宽度分配到 [available] 里。
///
/// 装得下就按理想宽度等比放大；装不下就只压缩「超出下限的那部分」。
List<double> _allocateWidths(
  double available,
  List<double> desired,
  double minWidth,
) {
  final int count = desired.length;
  if (!available.isFinite || available <= 0) return desired;

  final double sum = desired.fold<double>(0, (double a, double b) => a + b);
  if (sum <= available) {
    // 按理想宽度等比放大：短标签保持短，长标签仍然最宽。
    final double scale = available / sum;
    return <double>[for (final double width in desired) width * scale];
  }

  // 下限取 min(理想宽度, minWidth)：比 minWidth 还短的标签保留自己的理想
  // 宽度，不被强行拉宽；省下的预算全给真正需要压缩的长标签。
  // 极窄父宽度时下限之和仍可能超过 available，再用平均宽度兜一层，避免 Row 溢出。
  final double cap = available / count;
  final List<double> lower = <double>[
    for (final double width in desired) math.min(math.min(width, minWidth), cap),
  ];
  final List<double> widths = List<double>.of(lower);
  final double budget = available - lower.fold<double>(0, (a, b) => a + b);
  if (budget <= 0) return widths;

  double excess = 0;
  for (int i = 0; i < count; i++) {
    excess += math.max(0.0, desired[i] - lower[i]);
  }
  if (excess <= 0) {
    for (int i = 0; i < count; i++) {
      widths[i] += budget / count;
    }
    return widths;
  }
  for (int i = 0; i < count; i++) {
    widths[i] += budget * math.max(0.0, desired[i] - lower[i]) / excess;
  }
  return widths;
}
