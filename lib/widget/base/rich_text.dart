import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

/// 把带 `<tag>…</tag>` 标记的翻译串切成富文本片段。
///
/// easy_localization 4.0.0-dev 的 `tr()` 只返回 `String`，没有 RichText 能力。
/// 标记写进翻译串（而非代码里写死下标），因为不同语言高亮段的位置和数量不同：
///   zh-CN: "已选中 <b>3 个文件</b>，将删除 <b>原文件</b>"
///   en-US: "<b>3 files</b> selected, originals will be <b>deleted</b>"
///
/// [marks] 的 key 是标签名，value 是该段要套的样式；标签不显示，只影响样式。
/// 样式建议从 `Theme.of(context).textTheme` / `colorScheme` 取，自动跟随主题。
/// 未闭合或拼错的标签会原样留在文本里，方便开发期发现。
List<InlineSpan> trSpans(
  BuildContext context,
  String key, {
  List<String>? args,
  Map<String, String>? namedArgs,
  TextStyle? style,
  required Map<String, TextStyle> marks,
}) {
  final String raw = context.tr(key, args: args, namedArgs: namedArgs);
  // \1 反向引用保证开闭标签同名，避免 <b>x</i> 被误切。
  final RegExp pattern = RegExp(r'<(\w+)>(.*?)</\1>');
  final List<InlineSpan> spans = <InlineSpan>[];
  int cursor = 0;
  for (final Match m in pattern.allMatches(raw)) {
    if (m.start > cursor) {
      spans.add(TextSpan(text: raw.substring(cursor, m.start), style: style));
    }
    spans.add(TextSpan(text: m.group(2), style: marks[m.group(1)] ?? style));
    cursor = m.end;
  }
  if (cursor < raw.length) {
    spans.add(TextSpan(text: raw.substring(cursor), style: style));
  }
  return spans;
}
