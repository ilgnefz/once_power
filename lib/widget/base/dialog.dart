import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';

class const EasyDialog({
  super.key,
  required final Widget child,
  final double width = AppNumber.dialog,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return UnconstrainedBox(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.95,
          // UnconstrainedBox 会把父级约束全部解除；只给 minWidth 的话
          // maxWidth 仍是 infinity，内部 Row + Expanded 会抛
          // 「RenderFlex ... incoming width constraints are unbounded」，
          // 后续 hit test / hover 回调再抛异常就会污染 MouseTracker 状态。
          minWidth: width,
          maxWidth: width,
        ),
        child: Material(
          borderRadius: .circular(AppNumber.radius),
          color: theme.scaffoldBackgroundColor,
          child: ClipRRect(
            borderRadius: .circular(AppNumber.radius),
            child: child,
          ),
        ),
      ),
    );
  }
}
