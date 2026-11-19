import 'package:material_ui/material_ui.dart';
import 'package:once_power/widget/base/text.dart';

/// 条目的**选中样式**：底色 + 左上角序号角标。
///
/// 它是 `MultiSelectStyle.selectedBuilder` 的实现——选中样式只在这里画，不在
/// 条目的 `itemBuilder` 里画。这样拖动浮层（用的是 `itemBuilder` 的纯内容）
/// 不会带着选中底色飞起来，拖动样式留给 `proxyDecorator`。
///
/// - `index`：它在**点选顺序**里的位置（0 起）——画左上角角标；传 null 表示
///   不画角标（比如只选中一个时序号没有区分作用）。
/// - 组件只在条目被选中时调用它，所以这里不需要再判断「是否选中」。
class SelectedItem extends StatelessWidget {
  const SelectedItem({super.key, required this.index, required this.child});

  /// 在点选顺序里的位置（0 起）；null 表示不画序号角标。
  final int? index;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 底色画在内容**下方**，不会给文字 / 图标蒙色。
        Positioned.fill(
          child: ColoredBox(
            color: Theme.of(context).colorScheme.primaryContainer
                .withValues(alpha: .4),
          ),
        ),
        child,
        if (index != null)
          Positioned(
            top: 0,
            left: 0,
            child: Badge(
              // alignment: Alignment.topRight,
              backgroundColor: Theme.of(context).colorScheme.primary,
              // padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              label: BaseText(
                '${index! + 1}',
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 11,
              ),
            ),
            // child: Container(
            //   padding: .symmetric(horizontal: 4, vertical: 1),
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).colorScheme.primary,
            //     borderRadius: .circular(8),
            //   ),
            //   child: Text(
            //     '${index! + 1}',
            //     style: TextStyle(
            //       color: Theme.of(context).colorScheme.onPrimary,
            //       fontSize: 10,
            //     ),
            //   ),
            // ),
          ),
      ],
    );
  }
}
