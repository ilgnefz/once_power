import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';

import 'button.dart';

/// 高级操作子弹窗的统一框架（弹窗框架）。
///
/// 封装了「高度自适应 + 内容超高才滚动 + 底部按钮固定不滚」的整套布局：
///  - LayoutBuilder 拿父级给的有界高度；
///  - 内容区 ConstrainedBox(maxHeight) + SingleChildScrollView；
///  - ButtonGroup 固定在 Column 末尾，不随内容滚动。
///
/// 高度预留统一为 `widgetHeight + footerSpacing`：内容区与按钮之间
/// **只靠 Column.spacing 一处间距**，不要在 child 之间再手动插 SizedBox，
/// 否则间距叠成 spacing + SizedBox + spacing 会导致溢出。
class AdvanceDialogFrame extends StatelessWidget {
  const AdvanceDialogFrame({
    super.key,
    required this.child,
    required this.group,
    required this.onComplete,
    required this.onCompleteExit,
    required this.onGroupChange,
    this.footerSpacing = AppNumber.spaceMedium,
  });

  /// 可滚动内容区。调用方可传单个 widget，或自带间距的 Column。
  final Widget child;

  final String group;
  final void Function() onComplete;
  final void Function() onCompleteExit;
  final void Function(String) onGroupChange;

  /// 内容区与底部按钮之间的间距，默认 spaceMedium。
  /// 想给按钮上方更多留白就调大此值，框架会同步计入高度预留。
  // TODO: 删除
  final double footerSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ButtonGroup 固定高 widgetHeight；内容区与按钮之间只有
        // footerSpacing 这一处间距（Column.spacing），相加即底部固定预留。
        final double bottomReserve = AppNumber.widgetHeight + footerSpacing;
        final double contentMax = (constraints.maxHeight - bottomReserve)
            .clamp(0.0, double.infinity)
            .toDouble();
        return Column(
          spacing: footerSpacing,
          mainAxisSize: .min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: contentMax),
              child: SingleChildScrollView(
                padding: .symmetric(horizontal: AppNumber.padding),
                child: child,
              ),
            ),
            ButtonGroup(
              group: group,
              onComplete: onComplete,
              onCompleteExit: onCompleteExit,
              onGroupChange: onGroupChange,
            ),
          ],
        );
      },
    );
  }
}
