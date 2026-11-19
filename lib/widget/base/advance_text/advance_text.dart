/// 省略号位置可控的文本：默认在**中间**（保留首尾、吃掉中间），也可以放到
/// 前面或后面。如果内容是文件名，扩展名会完整保留，省略只发生在它前面。
///
/// ```dart
/// AdvanceText(
///   'quarterly_report_2024_final_v3.pdf',
///   style: const TextStyle(fontSize: 14),
/// )
/// // 窄容器里 → 'quarterl…al_v3.pdf'（扩展名始终完整）
/// ```
///
/// ## 省略号放在哪
///
/// [AdvanceText.ellipsisPosition] 三选一：
///
/// | 值 | 结果 | 适合 |
/// |---|---|---|
/// | [AdvanceTextEllipsisPosition.start] | `…al_v3.pdf` | 结尾才是重点 |
/// | [AdvanceTextEllipsisPosition.middle]（默认） | `quarterl…al_v3.pdf` | 文件名、长路径 |
/// | [AdvanceTextEllipsisPosition.end] | `quarterly_report_20…pdf` | 开头才是重点 |
///
/// 这里的「前 / 后」是**字面**首尾，不随 [TextDirection] 翻转。
///
/// ## 和 `TextOverflow.ellipsis` 的区别
///
/// Flutter 自带的省略只从**末尾**截断，长文件名会连扩展名一起吃掉，只剩
/// `quarterly_report_20…`，一眼看不出是什么类型的文件。这里默认从中间省略，
/// 并且把扩展名当成「不能动的尾巴」，只在这个尾巴前面省略。
///
/// [AdvanceTextEllipsisPosition.end] 看着接近原生行为，但仍会保住扩展名
/// （`head…pdf`）；想要和原生**完全一致**的末尾省略，把它和
/// `preserveExtension: false` 一起用。
///
/// ## 宽度从哪来
///
/// 用 [LayoutBuilder] 取父级给的 `maxWidth`，再用 `TextPainter` 二分出放得下的
/// 最长结果。**需要一个有界宽度**：父级给无限宽时（例如直接放进 `Row` 而没有
/// `Expanded`）没有可省略的余量，会原样显示。
///
/// ## 扩展名怎么认
///
/// 取最后一个 `.`，其后 1–8 位、以字母开头、只含字母数字，才算扩展名：
/// `report.v2.pdf` 认 `.pdf`；`v1.2`、`Mr. Smith`、以及句号结尾的句子都不会
/// 被误判。认错也无害 —— 只是多保住了一段尾巴。[preserveExtension] 关掉后
/// 就是纯粹的省略（扩展名可以随便被切）。
///
/// ## 单行与多行
///
/// [AdvanceText.maxLines] 默认 1。单行模式用 `softWrap: false`，原文里的换行 /
/// 制表符会被**折叠成空格** —— 否则 `maxLines: 1` 会在第一个换行处硬切，还不带
/// 省略号，看起来像文字丢了。
///
/// 设成 2 及以上时按宽度自动换行，并**保留原文的换行**（只把 `\r\n` / `\r`
/// 统一成 `\n`）。只有排到 [AdvanceText.maxLines] 还放不下才省略，省略号
/// 出现在最后一行；位置仍由 [AdvanceText.ellipsisPosition] 决定，中间模式的头尾
/// 按 [AdvanceText.headRatio] 分配，扩展名规则也照旧。
///
/// 多行的「中间」指**整段文本的首尾**：开头一段 + `…` + 结尾一段，拼起来后仍
/// 受行数限制。如果开头本身就占满了所有行，尾部会被压缩甚至退化成末尾省略 ——
/// 这是行数约束下的必然结果，不是 bug。
///
/// ## 富文本
///
/// 需要一段文字里混排多种样式（高亮的命中字符、灰色的扩展名）时用
/// [AdvanceText.rich]，传一个 `InlineSpan` 树，省略规则和纯文本完全一样：
///
/// ```dart
/// AdvanceText.rich(
///   TextSpan(children: <InlineSpan>[
///     TextSpan(text: 'quarterly_report_'),
///     TextSpan(text: '2024', style: TextStyle(color: Colors.red)),
///     TextSpan(text: '.pdf'),
///   ]),
/// )
/// // 窄容器里 → 'quart…2024.pdf'，被保留下来的每一段颜色都还在
/// ```
///
/// 实现上是把 span 树摊平成「字符 + 最终样式」再按区间重建，所以：
///
/// - 嵌套 span 的样式与外层合并（`inherit` 语义正常），省略后不会退化成一整段
///   单色文字；
/// - 放得下时**原样输出**原 span 树，`semanticsLabel` / `recognizer` 一个都不动；
/// - `WidgetSpan` 当作不可拆的整体：落在被省掉的中间就连它一起消失，落在头尾
///   则整块保留；
/// - 被省掉部分里的 `recognizer` / `semanticsLabel` 自然也一起没了（文字都没了）。
///
/// ## 无障碍
///
/// 屏幕上显示的是截断结果，但 `semanticsLabel` 默认给**完整原文**，读屏软件
/// 不会读到被砍掉一半的文件名。
library;

import 'dart:math' as math;

import 'package:flutter/gestures.dart' show GestureRecognizer;
import 'package:material_ui/material_ui.dart';

part 'advance_text_metrics.dart';

/// 默认的省略符：单个 `…`（不是三个句点，三点的宽度会被算进预算里）。
const String kAdvanceTextEllipsis = '…';

/// 省略号放在哪。
///
/// 这里的「前 / 后」指文本在字符串里的**字面**首尾，不随 [TextDirection] 翻转
/// （RTL 语言里也不会跑到视觉的另一侧）。
enum AdvanceTextEllipsisPosition {
  /// 省略在**前面**：保留结尾，`…_final_v3.pdf`。
  ///
  /// 适合「结尾才是重点」的内容：带日期的日志、以版本号 / 后缀收尾的名字。
  start,

  /// 省略在**中间**：保留首尾、吃掉中间，`quarterl…al_v3.pdf`。
  ///
  /// 默认值，也是文件名最常用的形态。
  middle,

  /// 省略在**后面**：保留开头，`quarterly_report_20…pdf`。
  ///
  /// 扩展名仍算「不能动的尾巴」，所以是 `头部 + … + 扩展名`；想连扩展名一起
  /// 吃掉（也就是 `Text` 的 `TextOverflow.ellipsis` 那种效果），把
  /// [AdvanceText.preserveExtension] 设成 `false`。
  end,
}

/// 把放不下的文本从中间省略的文字组件，文件名会保住扩展名。
class AdvanceText extends StatefulWidget {
  const AdvanceText(
    this.text, {
    super.key,
    this.style,
    this.maxLines = 1,
    this.ellipsis = kAdvanceTextEllipsis,
    this.ellipsisPosition = AdvanceTextEllipsisPosition.middle,
    this.preserveExtension = true,
    this.headRatio = 0.5,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.textScaler,
    this.locale,
    this.semanticsLabel,
  }) : richText = null,
       assert(maxLines >= 1, 'maxLines 至少是 1；只要单行就传 1。'),
       assert(
         headRatio >= 0 && headRatio <= 1,
         'headRatio 是「省略后头部占多少」，取值 0–1。',
       );

  /// 富文本版：内容是一棵 [InlineSpan] 树，可以按段设置样式（颜色、字重、
  /// 下划线……）。省略仍发生在**中间**，保留下来的每一段保留自己的样式。
  ///
  /// 参数含义与纯文本版完全一致；[text] 自动取 [richText] 的纯文本投影，
  /// 用于认扩展名和默认的 `semanticsLabel`。
  AdvanceText.rich(
    InlineSpan richText, {
    super.key,
    this.style,
    this.maxLines = 1,
    this.ellipsis = kAdvanceTextEllipsis,
    this.ellipsisPosition = AdvanceTextEllipsisPosition.middle,
    this.preserveExtension = true,
    this.headRatio = 0.5,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.textScaler,
    this.locale,
    this.semanticsLabel,
  }) : text = richText.toPlainText(),
       richText = richText,
       assert(maxLines >= 1, 'maxLines 至少是 1；只要单行就传 1。'),
       assert(
         headRatio >= 0 && headRatio <= 1,
         'headRatio 是「省略后头部占多少」，取值 0–1。',
       );

  /// 完整文本（原始内容，不做任何预处理）。
  ///
  /// 用 [AdvanceText.rich] 构造时，这里是 span 树的纯文本投影（`WidgetSpan`
  /// 记作 U+FFFC），主要用于认扩展名和默认的无障碍标签。
  final String text;

  /// 富文本内容；纯文本构造时为 null。
  final InlineSpan? richText;

  /// 文字样式；为 null 时沿用 `DefaultTextStyle`。
  final TextStyle? style;

  /// 最多显示几行，默认 1。
  ///
  /// * `1` → 单行，`softWrap: false`，原文的换行 / 制表符折叠成空格；
  /// * `> 1` → 按宽度自动换行、保留原文换行；排到这么多行还放不下时，
  ///   在最后一行做中间省略。
  final int maxLines;

  /// 省略符，默认 `…`。
  final String ellipsis;

  /// 省略号放在前面、中间还是后面，默认 [AdvanceTextEllipsisPosition.middle]。
  final AdvanceTextEllipsisPosition ellipsisPosition;

  /// 是否把文件扩展名当作不可省略的尾巴（默认开）。
  ///
  /// 关掉后就是普通的省略 —— 扩展名也可能被截掉一半。
  final bool preserveExtension;

  /// 省略后「头部」占保留字符数的比例，默认 `0.5`（前后各一半）。
  ///
  /// 只在 [ellipsisPosition] 为 [AdvanceTextEllipsisPosition.middle] 时生效；
  /// 省略在前面时头部是 0，省略在后面时尾部是 0，没有可分配的比例。
  ///
  /// 调小 → 多留尾部（文件名的后缀段、版本号更容易看清）；调大 → 多留开头。
  final double headRatio;

  /// 文本对齐方式（对中间省略后的结果生效，不影响「省在哪」）。
  final TextAlign textAlign;

  /// 文字方向；为 null 时取 [Directionality]。
  final TextDirection? textDirection;

  /// 文字缩放；为 null 时取 `MediaQuery.textScalerOf`。
  final TextScaler? textScaler;

  /// 语言标识（影响部分字体的字形选择与断词）。
  final Locale? locale;

  /// 无障碍标签；为 null 时用**完整原文**。
  final String? semanticsLabel;

  @override
  State<AdvanceText> createState() => _AdvanceTextState();
}

class _AdvanceTextState extends State<AdvanceText> {
  /// 上一次计算的输入指纹与结果，避免同一宽度下重复二分。
  int? _cacheKey;
  String? _cachedValue;

  /// 富文本版的结果缓存，和纯文本分开存：两者指纹不可比。
  int? _richCacheKey;
  InlineSpan? _cachedSpan;

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection =
        widget.textDirection ??
        Directionality.maybeOf(context) ??
        TextDirection.ltr;
    final TextScaler textScaler =
        widget.textScaler ?? MediaQuery.textScalerOf(context);

    // Text 内部就是把它和 DefaultTextStyle 合并；测量必须用同一份样式，
    // 否则量出来的宽度和实际排版的宽度对不上，最后会露出半个字。
    final TextStyle effectiveStyle = DefaultTextStyle.of(
      context,
    ).style.merge(widget.style);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth;

        // 富文本走 Text.rich：省略结果是一棵 span 树，不能再压成字符串。
        final InlineSpan? rich = widget.richText;
        if (rich != null) {
          final InlineSpan value = maxWidth.isFinite
              ? _resolveRich(
                  maxWidth: maxWidth,
                  style: effectiveStyle,
                  textDirection: textDirection,
                  textScaler: textScaler,
                )
              : rich;
          return Text.rich(
            value,
            style: widget.style,
            textAlign: widget.textAlign,
            textDirection: textDirection,
            textScaler: textScaler,
            locale: widget.locale,
            softWrap: widget.maxLines > 1,
            maxLines: widget.maxLines,
            overflow: TextOverflow.clip,
            semanticsLabel: widget.semanticsLabel ?? widget.text,
          );
        }

        final String value = maxWidth.isFinite
            ? _resolve(
                maxWidth: maxWidth,
                style: effectiveStyle,
                textDirection: textDirection,
                textScaler: textScaler,
              )
            : widget.text;

        return Text(
          value,
          style: widget.style,
          textAlign: widget.textAlign,
          textDirection: textDirection,
          textScaler: textScaler,
          locale: widget.locale,
          // 单行时关掉换行，避免结果被父级宽度重新折行；多行时按宽度自然断行。
          softWrap: widget.maxLines > 1,
          maxLines: widget.maxLines,
          // 结果已经保证放得下；这里不用 ellipsis，否则万一有亚像素误差，
          // 末尾会再冒出一个省略号。
          overflow: TextOverflow.clip,
          semanticsLabel: widget.semanticsLabel ?? widget.text,
        );
      },
    );
  }

  String _resolve({
    required double maxWidth,
    required TextStyle style,
    required TextDirection textDirection,
    required TextScaler textScaler,
  }) {
    final int key = Object.hash(
      widget.text,
      maxWidth,
      style,
      textDirection,
      textScaler,
      widget.ellipsis,
      widget.ellipsisPosition,
      widget.headRatio,
      widget.preserveExtension,
      widget.maxLines,
    );
    if (_cacheKey == key && _cachedValue != null) return _cachedValue!;

    final TextPainter painter = TextPainter(
      textDirection: textDirection,
      textScaler: textScaler,
      locale: widget.locale,
      maxLines: widget.maxLines,
    );

    // 用 TextPainter 自己的折行结果判断放不放得下：多行时宽度永远 ≤ maxWidth，
    // 不能再拿宽度比较，要看有没有超过 maxLines。
    bool fits(String value) {
      if (value.isEmpty) return true;
      painter.text = TextSpan(text: value, style: style);
      painter.layout(maxWidth: maxWidth);
      return !painter.didExceedMaxLines;
    }

    final String source = _prepareText(widget.text, maxLines: widget.maxLines);

    final String value = _fitText(
      text: source,
      maxWidth: maxWidth,
      maxLines: widget.maxLines,
      ellipsis: widget.ellipsis,
      position: widget.ellipsisPosition,
      headRatio: widget.headRatio,
      preserveExtension: widget.preserveExtension,
      fits: fits,
    );

    painter.dispose();

    _cacheKey = key;
    _cachedValue = value;
    return value;
  }

  /// 富文本版：和 [_resolve] 同一套指纹 + 二分，只是结果是一棵 span 树。
  ///
  /// 测量时把候选 span 挂在「根样式」下面，和 `Text.rich` 实际渲染的结构一致
  /// （`Text` 会把自己合成一个 `style: effectiveTextStyle` 的根 span）。
  InlineSpan _resolveRich({
    required double maxWidth,
    required TextStyle style,
    required TextDirection textDirection,
    required TextScaler textScaler,
  }) {
    final InlineSpan root = widget.richText!;
    final int key = Object.hash(
      root,
      maxWidth,
      style,
      textDirection,
      textScaler,
      widget.ellipsis,
      widget.ellipsisPosition,
      widget.headRatio,
      widget.preserveExtension,
      widget.maxLines,
    );
    if (_richCacheKey == key && _cachedSpan != null) return _cachedSpan!;

    final TextPainter painter = TextPainter(
      textDirection: textDirection,
      textScaler: textScaler,
      locale: widget.locale,
      maxLines: widget.maxLines,
    );

    bool fits(InlineSpan candidate) {
      painter.text = TextSpan(style: style, children: <InlineSpan>[candidate]);
      painter.layout(maxWidth: maxWidth);
      return !painter.didExceedMaxLines;
    }

    final _RichDocument doc = _RichDocument.of(
      root,
      maxLines: widget.maxLines,
    );

    final InlineSpan value =
        _fitRich(
          doc: doc,
          maxWidth: maxWidth,
          ellipsis: widget.ellipsis,
          position: widget.ellipsisPosition,
          headRatio: widget.headRatio,
          preserveExtension: widget.preserveExtension,
          fits: fits,
        ) ??
        const TextSpan();

    painter.dispose();

    _richCacheKey = key;
    _cachedSpan = value;
    return value;
  }
}
