part of 'advance_text.dart';

/// 认扩展名用的规则：1–8 位、以字母开头、只含字母数字。
///
/// 以字母开头这一条很关键 —— 否则 `3.14`、`v1.2` 这种小数会把 `14` / `2`
/// 当成扩展名，前端被莫名截掉。
final RegExp _kExtensionPattern = RegExp(r'^[A-Za-z][A-Za-z0-9]{0,7}$');

/// 单行模式里出现换行 / 制表符时，折叠成空格。
final RegExp _kLineBreaks = RegExp(r'[\r\n\t]+');

/// `WidgetSpan` 在纯文本里的占位符，与 `InlineSpan.toPlainText()` 一致。
const String _kPlaceholder = '\uFFFC';

/// 预处理原文。
///
/// * 单行：换行 / 制表符折叠成空格 —— 否则会在第一个换行处硬切且不带省略号；
/// * 多行：只统一换行符，保留原文的断行。
String _prepareText(String text, {required int maxLines}) {
  if (maxLines == 1) return text.replaceAll(_kLineBreaks, ' ');
  return text.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
}

/// 找出可视为扩展名的那个 `.` 的下标；不是文件名时返回 -1。
///
/// 只认最后一个点：`archive.tar.gz` → 下标指向 `.gz`，`archive.tar` 当作主体。
int _extensionDot(String text) {
  final int dot = text.lastIndexOf('.');
  // 点在开头（`.gitignore` 这种隐藏文件）或结尾（句子句号）都不算扩展名。
  if (dot <= 0 || dot >= text.length - 1) return -1;
  if (!_kExtensionPattern.hasMatch(text.substring(dot + 1))) return -1;
  return dot;
}

// ── 富文本：摊平成「字符 + 最终样式」，省略后再按样式拼回去 ─────────────

/// 富文本里的一个「原子」：一个字符，或一个不可拆的 [PlaceholderSpan]。
///
/// 按码点（rune）切而不是 code unit，理由和字符串版用 `runes` 一样：从代理对
/// 中间切会切出半个 emoji。样式在这一层已经和外层合并好，重建时照抄即可。
class _RichAtom {
  _RichAtom.text(this.text, this.style, this.recognizer) : span = null;

  /// [PlaceholderSpan]（`WidgetSpan` 等）整体当一个原子：要么全留，要么全丢。
  _RichAtom.placeholder(InlineSpan placeholder)
    : text = _kPlaceholder,
      style = null,
      recognizer = null,
      span = placeholder;

  final String text;
  final TextStyle? style;
  final GestureRecognizer? recognizer;

  /// 非空表示这是一个占位组件，重建时原样插回去。
  final InlineSpan? span;
}

/// 富文本摊平后的结果。
///
/// 摊平是「中间省略」的前提：只有摊平后才知道每个字符属于哪个样式片段，
/// 才能按「保留多少字符」去二分、再按样式重新拼出一段 span。
class _RichDocument {
  _RichDocument._(this.root, this.atoms);

  factory _RichDocument.of(InlineSpan root, {required int maxLines}) {
    final List<_RichAtom> atoms = <_RichAtom>[];
    _flattenSpan(root, null, atoms, maxLines: maxLines);
    return _RichDocument._(root, atoms);
  }

  /// 原始 span：放得下时直接渲染它，保留嵌套结构和 span 上的 `semanticsLabel`。
  final InlineSpan root;

  /// 按字符顺序排好的原子。
  final List<_RichAtom> atoms;

  int get length => atoms.length;

  /// 纯文本（占位组件记作 U+FFFC），只用来认扩展名。
  late final String text = atoms.map((_RichAtom atom) => atom.text).join();
}

/// 把 span 树摊平成原子列表，同时把嵌套的 [TextSpan.style] 合并成「最终样式」。
void _flattenSpan(
  InlineSpan span,
  TextStyle? inherited,
  List<_RichAtom> out, {
  required int maxLines,
}) {
  if (span is TextSpan) {
    final TextStyle? style = inherited == null
        ? span.style
        : (span.style == null ? inherited : inherited.merge(span.style));
    final String? text = span.text;
    if (text != null && text.isNotEmpty) {
      final String prepared = _prepareText(text, maxLines: maxLines);
      for (final int rune in prepared.runes) {
        out.add(
          _RichAtom.text(String.fromCharCode(rune), style, span.recognizer),
        );
      }
    }
    for (final InlineSpan child in span.children ?? const <InlineSpan>[]) {
      _flattenSpan(child, style, out, maxLines: maxLines);
    }
  } else if (span is PlaceholderSpan) {
    out.add(_RichAtom.placeholder(span));
  }
}

/// 把「纯文本里的 code unit 下标」换算成原子下标。
///
/// 原子按码点切，一个 emoji 在纯文本里占 2 个 code unit 却只占 1 个原子，
/// 所以扩展名那个 `.` 的位置不能直接当原子下标用。
int _atomIndexFromUnit(List<_RichAtom> atoms, int unitIndex) {
  int units = 0;
  for (int i = 0; i < atoms.length; i++) {
    if (units >= unitIndex) return i;
    units += atoms[i].text.length;
  }
  return atoms.length;
}

/// 把 `[start, end)` 区间的原子重建成一个 span；相邻同样式的原子合并成一段。
///
/// [asText] 为 true 时把占位组件换成它的 U+FFFC 占位字符 —— `TextPainter`
/// 直接量 `WidgetSpan` 会断言（它需要先由 `RenderParagraph` 塞好
/// `PlaceholderDimensions`），所以「测量」用纯文本版，「渲染」用真实 span。
InlineSpan? _composeAtoms(
  _RichDocument doc,
  int start,
  int end, {
  required bool asText,
}) {
  if (start >= end) return null;

  final List<InlineSpan> runs = <InlineSpan>[];
  final StringBuffer buffer = StringBuffer();
  TextStyle? bufferStyle;
  GestureRecognizer? bufferRecognizer;

  void flush() {
    if (buffer.isEmpty) return;
    runs.add(
      TextSpan(
        text: buffer.toString(),
        style: bufferStyle,
        recognizer: bufferRecognizer,
      ),
    );
    buffer.clear();
    bufferStyle = null;
    bufferRecognizer = null;
  }

  for (int i = start; i < end; i++) {
    final _RichAtom atom = doc.atoms[i];
    // 占位组件不能拆：整块插进去，前后的文字各自收尾。
    final InlineSpan? placeholder = atom.span;
    if (placeholder != null) {
      flush();
      runs.add(asText ? TextSpan(text: atom.text) : placeholder);
      continue;
    }
    if (buffer.isNotEmpty &&
        (atom.style != bufferStyle || atom.recognizer != bufferRecognizer)) {
      flush();
    }
    bufferStyle = atom.style;
    bufferRecognizer = atom.recognizer;
    buffer.write(atom.text);
  }
  flush();

  if (runs.isEmpty) return null;
  return TextSpan(children: runs);
}

/// 把富文本压到 [maxWidth] × `maxLines` 以内的省略。
///
/// 省略号放在哪由 [position] 决定，和纯文本版逐字一致：
///
/// * [AdvanceTextEllipsisPosition.start] → `…尾部 [+ 扩展名]`
/// * [AdvanceTextEllipsisPosition.middle] → `头部 + … + 尾部 [+ 扩展名]`
/// * [AdvanceTextEllipsisPosition.end] → `头部 + … [+ 扩展名]`
///
/// 扩展名同样算「不能动的尾巴」，整段保留，省略只发生在它前面。
///
/// 二分的仍是「保留多少字符」（中间模式下头尾按 [headRatio] 分），只是这里的
/// 字符带样式：缩掉的中间段连它的样式一起丢掉，留下来的每一段还是原来的颜色 /
/// 字重，不会变成一整段单色文字。
///
/// 返回 null 表示连省略号都放不下，调用方渲染空。
InlineSpan? _fitRich({
  required _RichDocument doc,
  required double maxWidth,
  required String ellipsis,
  required AdvanceTextEllipsisPosition position,
  required double headRatio,
  required bool preserveExtension,
  required bool Function(InlineSpan candidate) fits,
}) {
  if (doc.length == 0 || maxWidth <= 0) return null;

  // 拆出「不能动的尾巴」：`base` 是 `[0, baseLength)`，其后是扩展名。
  int baseLength = doc.length;
  if (preserveExtension) {
    final int dot = _extensionDot(doc.text);
    if (dot > 0) baseLength = _atomIndexFromUnit(doc.atoms, dot);
  }

  /// [asText] 见 [_composeAtoms]：测量传 true，最终渲染传 false。
  InlineSpan compose(int keep, {required bool asText}) {
    final List<InlineSpan> children = <InlineSpan>[];

    void add(int start, int end) {
      final InlineSpan? run = _composeAtoms(
        doc,
        start,
        end,
        asText: asText,
      );
      if (run != null) children.add(run);
    }

    final TextSpan dots = TextSpan(text: ellipsis);

    if (keep <= 0) {
      children.add(dots);
      add(baseLength, doc.length);
      return TextSpan(children: children);
    }
    if (keep >= baseLength) {
      add(0, baseLength);
      add(baseLength, doc.length);
      return TextSpan(children: children);
    }

    switch (position) {
      case AdvanceTextEllipsisPosition.start:
        children.add(dots);
        add(baseLength - keep, baseLength);
        add(baseLength, doc.length);
        break;
      case AdvanceTextEllipsisPosition.end:
        add(0, keep);
        children.add(dots);
        add(baseLength, doc.length);
        break;
      case AdvanceTextEllipsisPosition.middle:
        // 头部至少留 1 个字、尾部至少留 1 个字，否则就退化成「末尾省略」了。
        final int headLength = keep == 1
            ? 1
            : math.max(1, (keep * headRatio).round()).clamp(1, keep - 1);
        final int tailLength = keep - headLength;
        add(0, headLength);
        children.add(dots);
        if (tailLength > 0) add(baseLength - tailLength, baseLength);
        add(baseLength, doc.length);
        break;
    }
    return TextSpan(children: children);
  }

  /// 只量「文本形态」：占位组件按 U+FFFC 参与排版，避免 `TextPainter`
  /// 直接量 `WidgetSpan` 时断言。
  bool fitsKeep(int keep) => fits(compose(keep, asText: true));

  // 放得下：原样返回，保留原始嵌套（以及 span 上的 semanticsLabel / recognizer）。
  if (fitsKeep(doc.length)) return doc.root;

  // 扩展名自己就放不下：退化成对整串的普通省略，别为了尾巴把正文挤没。
  if (baseLength < doc.length && !fitsKeep(0)) {
    baseLength = doc.length;
  }

  // 连省略号都放不下，就什么都不显示，避免溢出到容器外。
  if (!fitsKeep(0)) return null;

  // 至少要省掉 base 里的一个字符，否则省略号是白加的。
  int low = 0;
  int high = baseLength - 1;
  while (low < high) {
    final int mid = low + ((high - low + 1) >> 1);
    if (fitsKeep(mid)) {
      low = mid;
    } else {
      high = mid - 1;
    }
  }
  return compose(low, asText: false);
}

/// 纯文本的省略：包一层单段富文本走 [_fitRich]。
///
/// 这样「省在哪、头尾怎么分、扩展名怎么保」只有一份实现；纯文本本来就是单一样式，
/// 转回来时把 span 摊平回字符串即可，行为与之前逐字一致。
///
/// [fits] 由调用方提供，内部复用同一个 `TextPainter`：单行看宽度、多行看有没有
/// 超过 `maxLines`，两种判断都收在它里面。
String _fitText({
  required String text,
  required double maxWidth,
  required int maxLines,
  required String ellipsis,
  required AdvanceTextEllipsisPosition position,
  required double headRatio,
  required bool preserveExtension,
  required bool Function(String value) fits,
}) {
  final _RichDocument doc = _RichDocument.of(
    TextSpan(text: text),
    maxLines: maxLines,
  );
  final InlineSpan? fitted = _fitRich(
    doc: doc,
    maxWidth: maxWidth,
    ellipsis: ellipsis,
    position: position,
    headRatio: headRatio,
    preserveExtension: preserveExtension,
    fits: (InlineSpan candidate) => fits(candidate.toPlainText()),
  );
  return fitted == null ? '' : fitted.toPlainText();
}
