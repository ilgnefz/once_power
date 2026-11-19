import 'package:material_ui/material_ui.dart';

/// 无 InkWell 反馈、hover 时文字变主题色的 TabBar。
///
/// 指示器 / 动画 / 分割线 / labelPadding / overlay / splash 全部由
/// `AppTabBarTheme` 提供，这里只做主题表达不了的两件事：
/// 1. hover 变色：`_TabStyle` 解析 labelColor 时只传 `WidgetState.selected`，
///    不感知 hovered，所以主题里的 `labelColor` 无法区分鼠标悬停；
/// 2. 单行省略：`Tab(text:)` 内置的是 `TextOverflow.fade`，英文长词会淡出。
class const EasyTabBar({
  super.key,
  required final List<String> labels,
  required final void Function(int) onTap,
}) extends StatefulWidget {
  @override
  State<EasyTabBar> createState() => _EasyTabBarState();
}

class _EasyTabBarState extends State<EasyTabBar> {
  /// -1 表示没有悬停。用 ValueNotifier 把重建限制在 TabBar 内部，
  /// 不会带着 TabBarView 一起 rebuild。
  final ValueNotifier<int> _hovered = ValueNotifier<int>(-1);

  @override
  void dispose() {
    _hovered.dispose();
    super.dispose();
  }

  void _onHover(bool value, int index) {
    // hover 回调发生在 MouseTracker 的 device update 阶段；组件若已卸载，
    // 再写已 dispose 的 ValueNotifier 会抛异常并把 MouseTracker 卡死。
    if (!mounted) return;
    if (value) {
      _hovered.value = index;
    } else if (_hovered.value == index) {
      // 相邻 tab 之间移动时，旧的 exit 可能晚于新的 enter，别把它清掉。
      _hovered.value = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color hoverColor =
        theme.tabBarTheme.labelStyle?.color ?? theme.colorScheme.primary;

    return ValueListenableBuilder<int>(
      valueListenable: _hovered,
      builder: (BuildContext context, int hovered, Widget? child) => TabBar(
        onHover: _onHover,
        onTap: widget.onTap,
        tabs: [
          for (int i = 0; i < widget.labels.length; i++)
            Tab(
              child: Text(
                widget.labels[i],
                textAlign: TextAlign.center,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                // 未 hover 传 null，沿用 _TabStyle 的 DefaultTextStyle，
                // 保留选中 / 未选中配色与切换动画。
                style: TextStyle(color: hovered == i ? hoverColor : null),
              ),
            ),
        ],
      ),
    );
  }
}
